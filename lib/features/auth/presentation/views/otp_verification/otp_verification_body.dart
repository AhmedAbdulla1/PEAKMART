import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/auth/data/model/request/send_otp_request.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/cutom_elevated_button.dart';
import 'package:peakmart/features/auth/presentation/state_mang/send_otp_cubit/send_otp_cubit.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/custom_otp_text_field.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/otp_resend_timer_row.dart';

class OtpVerificationBody extends StatefulWidget {
  const OtpVerificationBody({super.key});

  @override
  State<OtpVerificationBody> createState() => _OtpVerificationBodyState();
}

Function(String)? onSubmit;
String verificationCode = '';

class _OtpVerificationBodyState extends State<OtpVerificationBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppPadding.p29, AppPadding.p20, AppPadding.p29, 0),
      child: BlocConsumer<SendOtpCubit, SendOtpState>(
        listener: (context, state) {
          if (state is SendOtpSuccessState) {
            log('Success state');
          } else if (state is SendOtpFailureState) {
            log('Failure state');
          } else if (state is SendOtpLoadingState) {
            log('Loading state');
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                AppStrings.otpHeader,
                style: getMediumStyle(
                        fontSize: FontSize.s15, color: ColorManager.grey1)
                    .copyWith(fontFamily: FontConstants.fontMontserratFamily),
              ),
              SizedBox(
                height: 78.h,
              ),
              CustomOtpTextField(
                onSubmit: (value) {
                  verificationCode = value;
                  log('verification code is: $verificationCode');
                  log('value is: $value');
                },
              ),
              SizedBox(
                height: 25.h,
              ),
              const OtpResendTimerRow(),
              const Spacer(
                flex: 8,
              ),
              CustomElevatedButton(
                textButton: AppStrings.Continue,
                onPressed: () {
                  BlocProvider.of<SendOtpCubit>(context)
                      .sendOtp(sendOtpRequest: SendOtpRequest(key: '1549'));
                },
              ),
              const Spacer(
                flex: 1,
              )
            ],
          );
        },
      ),
    );
  }
}
