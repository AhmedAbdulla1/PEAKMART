import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Bid_Mart/app/app_prefs.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/error_ui/toast.dart';
import 'package:Bid_Mart/core/net/api_url.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/features/payment/domain/entities/fee_entity.dart';
import 'package:Bid_Mart/features/payment/domain/enum/enums.dart';
import 'package:Bid_Mart/features/payment/domain/usecases/payment_usecase.dart';
import 'package:Bid_Mart/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:Bid_Mart/features/payment/presentation/views/web_view_payment.dart';

const String bidRulesRoute = '/bid_rules';
const String contactUsRoute = '/contact_us';

class PaymentDialog extends StatefulWidget {
  final double netPrice;
  final PaymentProcess paymentProcess;

  const PaymentDialog({
    super.key,
    this.paymentProcess = PaymentProcess.enroll,
    required this.netPrice,
  });

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  final TextEditingController _bidController = TextEditingController();
  double? _amount;
  DateTime? _lastButtonPress;

  @override
  void initState() {
    super.initState();
    initPaymentModule();
  }

  @override
  void dispose() {
    _bidController.dispose();
    super.dispose();
  }

  double calculateFees(FeesEntity fees) {
    final feePercentage = widget.paymentProcess.getFee(fees);
    return widget.netPrice * feePercentage;
  }

  Future<void> _initiatePayment(
      BuildContext context, PaymentType paymentType) async {
    final now = DateTime.now();
    if (_lastButtonPress != null &&
        now.difference(_lastButtonPress!).inMilliseconds < 1000) {
      log('Button press ignored: too soon');
      return;
    }
    _lastButtonPress = now;
    log('Initiating payment with type: $paymentType...');
    log('Entered amount: $_amount');

    if (_amount == null) {
      Toast.show("Amount calculation failed",
          backgroundColor: ColorManager.red);
      return;
    }

    log('Processing payment...');

    try {
      final paymentUrl =
          '${APIUrls.initiatePayment}?name=${instance<AppPreferences>().getCookie('USER_NAME')}&price=$_amount&type=${paymentType.name}';
      log('Opening WebView with URL: $paymentUrl');

      final cubit = PaymentCubit(
        useCase: instance<FetchPaymentDetails>(),
        paymentProcess: widget.paymentProcess,
      );
      cubit.loadPaymentFees();

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => cubit,
            child: PaymentWebViewScreen(
              paymentUrl: paymentUrl,
              enteredBid: _amount!,
            ),
          ),
        ),
      );

      log('Returned to PaymentDialog with result: $result');
      if (result != null && result is Map) {
        final paymentStatus = result['payment_status'] ?? 'unknown';
        switch (paymentStatus) {
          case 'failed':
            final error = result['error'] ?? 'Unknown error';
            Toast.show("Payment failed: $error",
                backgroundColor: ColorManager.red);
            Navigator.of(context, rootNavigator: true).pop({
              'bid': _amount,
              'payment_status': 'failed',
            });
            break;
          case 'cancelled':
            Toast.show("Payment cancelled by user.",
                backgroundColor: ColorManager.red);
            Navigator.of(context, rootNavigator: true).pop({
              'bid': _amount,
              'payment_status': 'cancelled',
            });
            break;
          case 'navigated_away':
            Toast.show("Payment navigated away from.",
                backgroundColor: ColorManager.red);
            Navigator.of(context, rootNavigator: true).pop({
              'bid': _amount,
              'payment_status': 'navigated_away',
            });
            break;
          case 'success':
            Toast.show("Payment successful.",
                backgroundColor: ColorManager.green);
            Navigator.of(context, rootNavigator: true).pop({
              'fees': _amount,
              'tap_id': result['tap_id'],
              'payment_status': 'success',
            });
            break;
          default:
            Toast.show("Payment completed or cancelled.",
                backgroundColor: ColorManager.red);
            Navigator.of(context, rootNavigator: true).pop({
              'bid': _amount,
              'payment_status': 'unknown',
            });
            break;
        }
      } else {
        log('Unexpected null result from PaymentWebViewScreen, treating as cancelled.');
        Toast.show("Payment cancelled", backgroundColor: ColorManager.red);
        Navigator.of(context, rootNavigator: true).pop({
          'bid': _amount,
          'payment_status': 'cancelled',
        });
      }
    } catch (e, stack) {
      log('Payment error: $e', stackTrace: stack);

      Toast.show("Payment error: $e", backgroundColor: ColorManager.red);
      Navigator.of(context, rootNavigator: true).pop({
        'bid': _amount,
        'payment_status': 'failed',
      });
    }
  }

  void _closeDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = PaymentCubit(
      useCase: instance<FetchPaymentDetails>(),
      paymentProcess: widget.paymentProcess,
    );
    cubit.loadPaymentFees();

    return BlocProvider(
      create: (_) => cubit,
      child: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is FeesLoaded) {
            _amount = calculateFees(state.fees);
          }
        },
        builder: (context, state) {
          String processText;
          switch (widget.paymentProcess) {
            case PaymentProcess.upload:
              processText = 'The upload fee is ';
              break;
            case PaymentProcess.enroll:
              processText = 'The Bid insurance to enroll is ';
              break;
            case PaymentProcess.bid:
              processText = 'The bid insurance to enroll is ';
              break;
            case PaymentProcess.deposit:
              processText = 'The deposit fee is ';
              break;
            case PaymentProcess.withdraw:
              processText = 'The withdraw fee is ';
              break;
            case PaymentProcess.winner:
              processText = 'The winner fee is ';
              break;
          }

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: state is PaymentLoading
                  ? SizedBox(
                      height: 150.h,
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: _closeDialog,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        8.vGap,
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: processText,
                                  style: getBoldStyle(
                                    fontSize: FontSize.s16,
                                    color: context.isDarkMode
                                        ? ColorManager.white
                                        : ColorManager.black,
                                  ),
                                ),
                                TextSpan(
                                  text: _amount != null
                                      ? '$_amount\$'
                                      : 'Calculating...',
                                  style: getBoldStyle(
                                    fontSize: FontSize.s16,
                                    color: context.isDarkMode
                                        ? ColorManager.darkModePrimary
                                        : ColorManager.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        const BulletText(
                            'A tax fee will be added to the amount'),
                        const BulletText(
                            'In case of cancellation, 20% of the money won\'t be refunded'),
                        BulletTextWithLink(
                          text: 'For more details check the ',
                          linkText: 'bid rules',
                          onTap: () {
                            Navigator.pushNamed(context, bidRulesRoute);
                          },
                        ),
                        BulletTextWithLink(
                          text: 'or ',
                          linkText: 'contact us',
                          onTap: () {
                            Navigator.pushNamed(context, contactUsRoute);
                          },
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () => _initiatePayment(
                                  context, PaymentType.binance),
                              child: const Text(
                                'Pay with Binance',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            ElevatedButton(
                              onPressed: () =>
                                  _initiatePayment(context, PaymentType.tap),
                              child: const Text(
                                'Pay with Tap',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}

class BulletText extends StatelessWidget {
  final String text;

  const BulletText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: getRegularStyle(fontSize: FontSize.s14),
        ),
        Expanded(
          child: Text(
            text,
            style: getRegularStyle(fontSize: FontSize.s14),
          ),
        ),
      ],
    );
  }
}

class BulletTextWithLink extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onTap;

  const BulletTextWithLink({
    super.key,
    required this.text,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: getRegularStyle(fontSize: FontSize.s14),
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                text,
                style: getRegularStyle(fontSize: FontSize.s14),
              ),
              TextButton(
                onPressed: onTap,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  linkText,
                  style: getRegularStyle(
                    fontSize: FontSize.s15,
                    color: context.isDarkMode
                        ? ColorManager.blueLightest
                        : ColorManager.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
