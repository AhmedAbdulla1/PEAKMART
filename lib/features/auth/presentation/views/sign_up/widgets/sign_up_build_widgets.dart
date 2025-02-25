import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/account_creation_or_login_prompt.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/cutom_elevated_button.dart';
import 'package:peakmart/features/auth/presentation/state_mang/social_sign_in_cubit/social_sign_in_cubit.dart';
import 'package:peakmart/features/auth/presentation/views/login/widgets/other_login_ways.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/sign_up_functions.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/widgets/register_agreement_text.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/widgets/sign_up_user_accept_data.dart';

// karimmm kemooo@gmail.com 01223239089 Ka123008008@
class SignUpBuildWidgets extends StatefulWidget {
  const SignUpBuildWidgets({super.key});

  @override
  State<SignUpBuildWidgets> createState() => _SignUpBuildWidgetsState();
}

late String userName, email, phoneNumber, password, confirmPass;

late TextEditingController usernameController;
late TextEditingController emailController;
late TextEditingController phoneController;
late TextEditingController passwordController;
late TextEditingController confirmPassController;
GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _SignUpBuildWidgetsState extends State<SignUpBuildWidgets> {
  bool isButtonActive = false;
  String countryCode = '20';
  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    usernameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPassController = TextEditingController();

    _addListeners();
  }

  void _addListeners() {
    for (var controller in [
      usernameController,
      emailController,
      phoneController,
      passwordController,
      confirmPassController
    ]) {
      controller.addListener(_checkFormValidation);
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    super.dispose();
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
          80.vGap,
          Text(
            AppStrings.createAccount,
            style: getSemiBoldStyle(
                    fontSize: FontSize.s28, color: ColorManager.black)
                .copyWith(fontFamily: FontConstants.fontMontserratFamily),
          ),
          34.vGap,
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
          15.vGap,
          const RegisterAgreementText(),
          15.vGap,
          CustomElevatedButton(
            textButton: AppStrings.signUp,
            onPressed: !isButtonActive
                ? null
                : () async {
                    acceptUserData(countryCode);
                    if (formKey.currentState!.validate()) {
                      if (confirmPass == password) {
                        await userRegister(context);
                      } else {
                        passNotTheSame(context);
                      }
                    }
                  },
          ),
          60.vGap,
          BlocProvider(
            create: (context) => SignInWithSocialCubit(),
            child: const OtherLoginWays(),
          ),
          15.vGap,
          AccountCreationOrLoginPrompt(
            text: AppStrings.alreadyHaveAnAccount,
            textButton: AppStrings.login,
          )
        ],
      ),
    );
  }
}
