import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/app/resources/color_manager.dart';
import 'package:peakmart/app/resources/font_manager.dart';
import 'package:peakmart/app/resources/style_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/account_creation_or_login_prompt.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/cutom_elevated_button.dart';
import 'package:peakmart/features/auth/presentation/views/sign_in/widgets/other_login_ways.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/widgets/register_agreement_text.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/widgets/sign_up_user_accept_data.dart';
class SignUpBuildWidgets extends StatefulWidget {
  const SignUpBuildWidgets({super.key});

  @override
  State<SignUpBuildWidgets> createState() => _SignUpBuildWidgetsState();
}

String? email, password, phoneNumber;

class _SignUpBuildWidgetsState extends State<SignUpBuildWidgets> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 80,
          ),
          Text(
            'Create an account',
            style: getSemiBoldStyle(
                    fontSize: FontSize.s32, color: ColorManager.black)
                .copyWith(fontFamily: FontConstants.fontMontserratFamily),
          ),
          SizedBox(
            height: 51.h,
          ),
          SignUpUserAcceptData(
            onEmailChanged: (value) {
              email = value;
            },
            onPasswordChanged: (value) {
              password = value;
            },
            onPhoneNumberChanged: (value) {
              phoneNumber = value;
            },
          ),
          SizedBox(
            height: 15.h,
          ),
          const RegisterAgreementText(),
          SizedBox(
            height: 15.h,
          ),
           CustomElevatedButton(
            textButton: 'Create an account',onPressed: () {
              
            },
          ),
          SizedBox(
            height: 60.h,
          ),
          const OtherLoginWays(),
          SizedBox(
            height: 15.h,
          ),
          const AccountCreationOrLoginPrompt(
            text: 'Already have an account?',
            textButton: 'Login',
          )
        ],
      ),
    );
  }
}
