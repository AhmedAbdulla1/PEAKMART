import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';

// Placeholder routes (replace with your actual routes)
const String bidRulesRoute = '/bid_rules';
const String contactUsRoute = '/contact_us';

// Tap Payments configuration
const String tapSandboxSecretKey = 'sk_test_ngxsuqmWN617hST5cI8LfEQ4'; // Replace with your test secret key
const String tapBundleId = 'com.peakmart.app'; // Replace with your app's bundle ID

class BidDialog extends StatefulWidget {
  final double higherPrice;

  const BidDialog({
    super.key,
    required this.higherPrice,
  });

  @override
  State<BidDialog> createState() => _BidDialogState();
}

class _BidDialogState extends State<BidDialog> {
  final TextEditingController _bidController = TextEditingController();
  String? _errorMessage;
  double? _enteredBid;
  bool _isProcessingPayment = false;
  bool _isSessionActive = false;
  DateTime? _lastButtonPress;

  @override
  void dispose() {
    _bidController.dispose();
    super.dispose();
  }

  void _validateBid(String value) {
    setState(() {
      if (value.isEmpty) {
        _errorMessage = 'Please enter a bid amount';
        _enteredBid = null;
        return;
      }
      final double? bid = double.tryParse(value);
      if (bid == null) {
        _errorMessage = 'Please enter a valid number';
        _enteredBid = null;
      } else if (bid <= widget.higherPrice) {
        _errorMessage = 'Bid must be greater than ${widget.higherPrice}\$';
        _enteredBid = null;
      } else {
        _errorMessage = null;
        _enteredBid = bid;
      }
    });
  }

  Future<void> _initiatePayment(BuildContext context) async {
    final now = DateTime.now();
    if (_lastButtonPress != null &&
        now.difference(_lastButtonPress!).inMilliseconds < 1000) {
      log('Button press ignored: too soon');
      return;
    }
    _lastButtonPress = now;

    log('Initiating payment...');
    if (_enteredBid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid bid')),
      );
      return;
    }

    if (_isSessionActive) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Another payment session is active. Please wait.')),
      );
      return;
    }

    setState(() {
      _isProcessingPayment = true;
      _isSessionActive = true;
      log('Session marked as active');
    });

    try {
      // Calculate 5% tax and total amount
      final double taxFee = _enteredBid! * 0.05;
      final double totalAmount = _enteredBid! + taxFee;
      log('Total amount: $totalAmount, Tax: $taxFee');

      // Configure payment session
      log('Configuring session...');
       GoSellSdkFlutter.sessionConfigurations(

        trxMode: TransactionMode.PURCHASE,
        transactionCurrency: 'USD',
        amount: totalAmount,
        customer: Customer(
          customerId: '',
          email: 'test@tap.company',
          isdNumber: '965',
          number: '00000000',
          firstName: 'Test',
          middleName: '',
          lastName: 'User',
          metaData: null,
        ),
        paymentItems: [
          PaymentItem(
            name: 'Bid Payment',
            amountPerUnit: totalAmount,
            quantity: Quantity(value: 1),
            description: 'Payment for bid',
            taxes: [
              Tax(
                amount: Amount(type: 'F', value: taxFee, minimumFee: 0, maximumFee: 0),
                name: 'Tax',
                description: '5% tax',
              ),
            ],
            totalAmount: totalAmount.toInt(),
          ),
        ],
        taxes: [
          Tax(
            amount: Amount(type: 'F', value: taxFee, minimumFee: 0, maximumFee: 0),
            name: 'Tax',
            description: '5% tax',
          ),
        ],
        postURL: 'https://api.tap.company/v2/charges/', // Replace with your backend URL
        paymentDescription: 'Payment for bid',
        paymentMetaData: {'bid_id': 'bid_${DateTime.now().millisecondsSinceEpoch}'},
        paymentReference: Reference(
          acquirer: 'tap',
          gateway: 'tap',
          payment: 'payment',
          track: 'track',
          transaction: 'trans_${DateTime.now().millisecondsSinceEpoch}',
          order: 'order_${DateTime.now().millisecondsSinceEpoch}',
        ),
        paymentStatementDescriptor: 'PeakMart Bid',
        isUserAllowedToSaveCard: true,
        isRequires3DSecure: true,
        receipt: Receipt(true, false),
        authorizeAction: AuthorizeAction(type: AuthorizeActionType.CAPTURE, timeInHours: 0),
        merchantID: '',
        allowedCadTypes: CardType.CREDIT,
        applePayMerchantID: '',
        allowsToSaveSameCardMoreThanOnce: false,
        cardHolderName: 'Test User',
        allowsToEditCardHolderName: false,
        paymentType: PaymentType.ALL,
        sdkMode: SDKMode.Sandbox,
        shippings: [],
      );
      log('Session configured');

      // Start payment
      log('Starting payment...');
      final tapSDKResult = await GoSellSdkFlutter.startPaymentSDK;
      log('Payment result: $tapSDKResult');

      // Handle payment result
      setState(() {
        switch (tapSDKResult['sdk_result']) {
          case 'SUCCESS':
            if (tapSDKResult['trx_mode'] == 'CHARGE' && tapSDKResult['status'] == 'CAPTURED') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment successful!')),
              );
              Navigator.pop(context, {
                'bid': _enteredBid,
                'payment_status': 'success',
                'transaction_id': tapSDKResult['charge_id'],
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Payment failed: ${tapSDKResult['message'] ?? 'Unknown error'}')),
              );
              Navigator.pop(context, {
                'bid': _enteredBid,
                'payment_status': 'failed',
              });
            }
            break;
          case 'FAILED':
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment failed: ${tapSDKResult['message'] ?? 'Unknown error'}')),
            );
            Navigator.pop(context, {
              'bid': _enteredBid,
              'payment_status': 'failed',
            });
            break;
          case 'SDK_ERROR':
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'SDK Error: Code ${tapSDKResult['sdk_error_code']} - ${tapSDKResult['sdk_error_message']}',
                ),
              ),
            );
            Navigator.pop(context, {
              'bid': _enteredBid,
              'payment_status': 'failed',
            });
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Payment error: Unknown result')),
            );
            Navigator.pop(context, {
              'bid': _enteredBid,
              'payment_status': 'failed',
            });
        }
      });
    } catch (e, stack) {
      log('Payment error: $e', stackTrace: stack);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment error: $e')),
      );
      Navigator.pop(context, {
        'bid': _enteredBid,
        'payment_status': 'failed',
      });
    } finally {
      setState(() {
        _isProcessingPayment = false;
        _isSessionActive = false;
        log('Session reset');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'The highest bid for this product currently is ',
                    style: getBoldStyle(
                      fontSize: FontSize.s16,
                      color: context.isDarkMode ? ColorManager.white : ColorManager.black,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.higherPrice}\$',
                    style: getBoldStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            // Rules
            const BulletText('You MUST enter a number larger than the highlighted number'),
            const BulletText('A tax fee of 5% will be added to the number you enter'),
            const BulletText(
                'In case you are the highest bidder and want to cancel 20% of the money won\'t be refunded'),
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
            // Bid Input
            TextField(
              controller: _bidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'YOUR BID',
                hintText: 'This price may change after (7s)',
                errorText: _errorMessage,
              ),
              onChanged: _validateBid,
            ),
            SizedBox(height: 12.h),
            // Bid Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                onPressed: (){
                  GoSellSdkFlutter.terminateSession();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.textFormErrorBorder,
                ),
                child: Text(
                  'Cancel',
                  style: getBoldStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.white,
                  ),
                ),
              ),
                ElevatedButton(
                  onPressed: (_enteredBid != null &&
                      _enteredBid! > widget.higherPrice &&
                      !_isProcessingPayment)
                      ? () => _initiatePayment(context)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: _isProcessingPayment
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                    'Bid',
                    style: getBoldStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}

// Bullet point widget
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

// Bullet point with link
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
                    fontSize: FontSize.s14,
                    color: ColorManager.blue,
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