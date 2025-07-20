import 'dart:developer';

import 'package:Bid_Mart/core/error_ui/dialogs/show_dialog.dart';
import 'package:Bid_Mart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:Bid_Mart/core/error_ui/error_viewer/toast/errv_toast_options.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/string_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/core/resources/values_manager.dart';
import 'package:Bid_Mart/core/widgets/waiting_widget.dart';
import 'package:Bid_Mart/features/auth/data/model/request/send_otp_request.dart';
import 'package:Bid_Mart/features/auth/data/model/request/verfiy_otp_request.dart';
import 'package:Bid_Mart/features/auth/domain/entity/register_entity.dart';
import 'package:Bid_Mart/features/auth/presentation/shared_widgets/cutom_elevated_button.dart';
import 'package:Bid_Mart/features/auth/presentation/state_mang/otp_verfication_cubit/otp_verfication_cubit.dart';
import 'package:Bid_Mart/features/auth/presentation/views/otp_verification/custom_otp_text_field.dart';
import 'package:Bid_Mart/features/auth/presentation/views/otp_verification/otp_resend_timer_row.dart';
import 'package:Bid_Mart/features/auth/presentation/views/reset_password/widgets/success_bottom_sheet.dart';
import 'package:Bid_Mart/features/auth/presentation/views/signup_for_bid/hold_screen.dart';
import 'package:Bid_Mart/features/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpVerificationBody extends StatefulWidget {
  const OtpVerificationBody({
    super.key,
    this.registerEntity,
    this.autoSend = false,
  });

  final RegisterEntity? registerEntity;
  final bool autoSend;

  @override
  State<OtpVerificationBody> createState() => _OtpVerificationBodyState();
}

class _OtpVerificationBodyState extends State<OtpVerificationBody> {
  String verificationCode = '';
  late bool autoSend;

  @override
  void initState() {
    super.initState();
    autoSend = widget.autoSend;

    if (widget.registerEntity != null) {
      context.read<OtpVerfictionCubit>().sendOtp(
            sendOtpRequest: SendOtpRequest(
              key: 'SM',
              username: widget.registerEntity!.userName,
              email: widget.registerEntity!.email,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppPadding.p29, AppPadding.p20, AppPadding.p29, 0),
      child: BlocConsumer<OtpVerfictionCubit, OtpVerificationState>(
        listener: (context, state) {
          if (state is OtpVerificationSuccessState && state.isVerified) {
            log('✅ OTP Verified Successfully');
            showSuccessBottomSheet(context, AppStrings.otpSuccessMessage);
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.pushReplacementNamed(context, MainView.routeName);
            });
          }

          if (state is WatsAppOtpVerificationSuccessState) {
            Navigator.pushReplacementNamed(context, HoldScreen.routeName);
          }

          if (state is OtpVerificationFailureState) {
            log('❌ OTP Verification Failed: ${state.errors}');
            if (Navigator.canPop(context)) Navigator.pop(context);

            ErrorViewer.showError(
              errorViewerOptions: ErrVToastOptions(
                textColor: ColorManager.white,
                backGroundColor: ColorManager.lightGrey,
              ),
              context: context,
              error: state.errors,
              callback: state.onRetry,
            );
          }

          if (state is OtpVerificationLoadingState) {
            log('🔄 Loading...');
            ShowDialog().showElasticDialog(
              context: context,
              builder: (context) => const WaitingWidget(),
              barrierDismissible: false,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<OtpVerfictionCubit>();
          final isLoading = state is OtpVerificationLoadingState;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Text(
                AppStrings.otpHeader,
                style: getMediumStyle(
                        fontSize: FontSize.s15,
                        color: context.isDarkMode
                            ? ColorManager.grey
                            : ColorManager.grey1)
                    .copyWith(fontFamily: FontConstants.fontMontserratFamily),
              ),
              SizedBox(height: 78.h),
              CustomOtpTextField(
                onSubmit: (value) {
                  verificationCode = value;
                  log('📩 Code submitted: $value');
                  verfiyOtp(context);
                },
              ),
              SizedBox(height: 25.h),
              OtpResendTimerRow(
                autoStart: autoSend,
                onPressed: () {
                  if (widget.registerEntity != null) {
                    cubit.sendOtp(
                      sendOtpRequest: SendOtpRequest(
                        key: 'SM',
                        username: widget.registerEntity!.userName,
                        email: widget.registerEntity!.email,
                      ),
                    );
                  } else {
                    cubit.sendWatsAppOtp();
                  }
                },
              ),
              const Spacer(flex: 8),
              CustomElevatedButton(
                minimumSize: Size(double.infinity, 50.h),
                textButton: AppStrings.continue_,
                onPressed: isLoading
                    ? null
                    : () {
                        if (verificationCode.isNotEmpty) {
                          log('➡️ Continue with code: $verificationCode');
                          verfiyOtp(context);
                        } else {
                          log('⚠️ Empty verification code');
                        }
                      },
              ),
              const Spacer(flex: 1),
            ],
          );
        },
      ),
    );
  }

  void verfiyOtp(BuildContext context) {
    final cubit = context.read<OtpVerfictionCubit>();

    if (widget.registerEntity != null) {
      cubit.verfiyOtp(
        verfiyOtpRequest: VerfiyOtpRequest(
          email: widget.registerEntity!.email,
          username: widget.registerEntity!.userName,
          otp: verificationCode,
        ),
      );
    } else {
      cubit.verifyWatsAppOtp(
        verifyOtpRequest: VerfiyOtpRequest(
          email: '',
          username: '',
          otp: verificationCode,
        ),
      );
    }

    log('🔒 Sent OTP: ${cubit.otp}');
  }
}

void showSuccessBottomSheet(BuildContext context, String message) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return SuccessBottomSheet(
        otpVerfictionCubit: OtpVerfictionCubit(),
        textMessage: message,
      );
    },
  );
}
