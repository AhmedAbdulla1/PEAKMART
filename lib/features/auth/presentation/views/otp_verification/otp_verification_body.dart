import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/routes_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/account_creation_or_login_prompt.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/cutom_elevated_button.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/custom_otp_text_field.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/change_password.dart';

class OtpVerificationBody extends StatelessWidget {
  const OtpVerificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(29, 20, 29, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Enter the code we sent you to your e-mail here',
            style: getMediumStyle(
                    fontSize: FontSize.s15, color: ColorManager.grey1)
                .copyWith(fontFamily: FontConstants.fontMontserratFamily),
          ),
          SizedBox(
            height: 78.h,
          ),
          const CustomOtpTextField(),
          SizedBox(
            height: 25.h,
          ),
          const AccountCreationOrLoginPrompt(
              text: 'Didn\'t receive a code?', textButton: 'Resend'),
          const Spacer(
            flex: 8,
          ),
          CustomElevatedButton(
            textButton: 'Continue',
            onPressed: () {
              Navigator.pushNamed(context,Routes.mainScreen);
            },
          ),
         const Spacer(
            flex: 1,
          )
        ],
      ),
    );
  }
}
