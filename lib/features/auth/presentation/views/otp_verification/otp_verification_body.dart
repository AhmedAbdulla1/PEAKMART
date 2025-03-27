import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/error_ui/dialogs/show_dialog.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/error_ui/error_viewer/toast/errv_toast_options.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/data/model/request/send_otp_request.dart';
import 'package:peakmart/features/auth/data/model/request/verfiy_otp_request.dart';
import 'package:peakmart/features/auth/domain/entity/register_entity.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/cutom_elevated_button.dart';
import 'package:peakmart/features/auth/presentation/state_mang/otp_verfication_cubit/otp_verfication_cubit.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/custom_otp_text_field.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/otp_resend_timer_row.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/widgets/success_bottom_sheet.dart';
import 'package:peakmart/features/main/main_view.dart';

class OtpVerificationBody extends StatefulWidget {
  const OtpVerificationBody({
    super.key,
    this.registerEntity,
  });

  final RegisterEntity? registerEntity;

  @override
  State<OtpVerificationBody> createState() => _OtpVerificationBodyState();
}

String verificationCode = '';

class _OtpVerificationBodyState extends State<OtpVerificationBody> {
  @override
  void initState() {
    super.initState();
    if (widget.registerEntity != null) {
      BlocProvider.of<OtpVerfictionCubit>(context).sendOtp(
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
          if (state is OtpVerificationSuccessState) {
            // Navigator.pop(context);
            if (state.isVerified) {
              log('Success state in verify otp');
              state.isVerified
                  ? showSuccessBottomSheet(
                      context, AppStrings.otpSuccessMessage)
                  : null;

              state.isVerified
                  ? Future.delayed(const Duration(seconds: 3), () {
                      Navigator.pushReplacementNamed(
                          context, MainView.routeName);
                    })
                  : null;
            }
          } else if (state is OtpVerificationFailureState) {
            log('Failure state');
            Navigator.pop(context);
            ErrorViewer.showError(
                errorViewerOptions: ErrVToastOptions(
                  textColor: ColorManager.white,
                  backGroundColor: ColorManager.lightGrey,
                ),
                context: context,
                error: state.errors,
                callback: state.onRetry);
          } else if (state is OtpVerificationLoadingState) {
            log('Loading state');
            ShowDialog().showElasticDialog(
              context: context,
              builder: (context) => const WaitingWidget(),
              barrierDismissible: false,
            );
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Text(
                AppStrings.otpHeader,
                style: getMediumStyle(
                        fontSize: FontSize.s15, color: ColorManager.grey1)
                    .copyWith(fontFamily: FontConstants.fontMontserratFamily),
              ),
              SizedBox(height: 78.h),
              CustomOtpTextField(
                onSubmit: (value) {
                  verificationCode = value;
                  verfiyOtp(context);

                  log('verification code is: $verificationCode');
                  log('value is: $value');
                },
              ),
              SizedBox(height: 25.h),
              OtpResendTimerRow(
                onPressed: () {
                  if (widget.registerEntity != null) {
                    BlocProvider.of<OtpVerfictionCubit>(context).sendOtp(
                      sendOtpRequest: SendOtpRequest(
                        key: 'SM',
                        username: widget.registerEntity!.userName,
                        email: widget.registerEntity!.email,
                      ),
                    );
                  } else {
                    BlocProvider.of<OtpVerfictionCubit>(context)
                        .sendWatsAppOtp();
                  }
                },
              ),
              const Spacer(flex: 8),
              CustomElevatedButton(
                textButton: AppStrings.Continue,
                onPressed: () {
                  if (verificationCode.isNotEmpty) {
                    verfiyOtp(context);
                  } else {
                    log('Verification code is empty');
                  }
                },
              ),
              const Spacer(flex: 1)
            ],
          );
        },
      ),
    );
  }

  void verfiyOtp(BuildContext context) {
    if (widget.registerEntity != null) {
      BlocProvider.of<OtpVerfictionCubit>(context).verfiyOtp(
          verfiyOtpRequest: VerfiyOtpRequest(
              email: widget.registerEntity!.email,
              username: widget.registerEntity!.userName,
              otp: verificationCode));
    } else {
      BlocProvider.of<OtpVerfictionCubit>(context).verifyWatsAppOtp(
          verifyOtpRequest: VerfiyOtpRequest(
        email: '',
        username: '',
        otp: verificationCode,
      ));
    }
    log('otp is: ${BlocProvider.of<OtpVerfictionCubit>(context).otp}');
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
