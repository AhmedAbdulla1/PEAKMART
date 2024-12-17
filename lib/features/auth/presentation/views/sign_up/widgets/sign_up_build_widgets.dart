import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/account_creation_or_login_prompt.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/cutom_elevated_button.dart';
import 'package:peakmart/features/auth/presentation/views/login/widgets/other_login_ways.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/sign_up_model.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/widgets/register_agreement_text.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/widgets/sign_up_user_accept_data.dart';

// karimmm kemooo@gmail.com 01223239089 Ka123008008@
class SignUpBuildWidgets extends StatefulWidget {
  const SignUpBuildWidgets({super.key});

  @override
  State<SignUpBuildWidgets> createState() => _SignUpBuildWidgetsState();
}

late String userName, email, phoneNumber, password, confirmPass;

final TextEditingController usernameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPassController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _SignUpBuildWidgetsState extends State<SignUpBuildWidgets> {
  bool isButtonActive = false;
  String countryCode = '20';
  @override
  void initState() {
    super.initState();
    usernameController.addListener(_checkFormValidation);
    emailController.addListener(_checkFormValidation);
    phoneController.addListener(_checkFormValidation);
    passwordController.addListener(_checkFormValidation);
    confirmPassController.addListener(_checkFormValidation);
  }

  void _checkFormValidation() {
    bool allFieldsFilled = usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPassController.text.isNotEmpty;

    if (isButtonActive != allFieldsFilled) {
      setState(() {
        isButtonActive = allFieldsFilled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 80.h,
          ),
          Text(
            AppStrings.createAccount,
            style: getSemiBoldStyle(
                    fontSize: FontSize.s28, color: ColorManager.primary)
                .copyWith(fontFamily: FontConstants.fontMontserratFamily),
          ),
          SizedBox(
            height: 34.h,
          ),
          SignUpUserAcceptData(
            usernameController: usernameController,
            emailController: emailController,
            phoneController: phoneController,
            passwordController: passwordController,
            confirmPassController: confirmPassController,
            onCountryChanged: (country) {
              countryCode = country.dialCode;
              log('Country code is: $countryCode');
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
            textButton: AppStrings.createAccount,
            onPressed: !isButtonActive
                ? null
                : () async {
                    acceptUserData(countryCode); // تمرير رمز الدولة هنا
                    if (formKey.currentState!.validate()) {
                      if (confirmPass == password) {
                        await userRegister(context);
                      } else {
                        passNotTheSame(context);
                      }
                    }
                  },
          ),
          SizedBox(
            height: 60.h,
          ),
          const OtherLoginWays(),
          SizedBox(
            height: 15.h,
          ),
          AccountCreationOrLoginPrompt(
            text: AppStrings.alreadyHaveAnAccount,
            textButton: AppStrings.login,
          )
        ],
      ),
    );
  }
}
