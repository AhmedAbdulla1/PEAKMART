import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/auth/data/model/request/register_request.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/account_creation_or_login_prompt.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/cutom_elevated_button.dart';
import 'package:peakmart/features/auth/presentation/state_mang/register_cubit.dart/register_cubit.dart';
import 'package:peakmart/features/auth/presentation/state_mang/social_sign_in_cubit/social_sign_in_cubit.dart';
import 'package:peakmart/features/auth/presentation/views/login/widgets/other_login_ways.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/sign_up_functions.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/widgets/register_agreement_text.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/widgets/sign_up_user_accept_data.dart';

class SignUpBuildWidgets extends StatefulWidget {
  const SignUpBuildWidgets({super.key});

  @override
  State<SignUpBuildWidgets> createState() => _SignUpBuildWidgetsState();
}

class _SignUpBuildWidgetsState extends State<SignUpBuildWidgets> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isButtonActive = ValueNotifier<bool>(false);
  String countryCode = '20';

  @override
  void initState() {
    super.initState();
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

  void _checkFormValidation() {
    isButtonActive.value = usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPassController.text.isNotEmpty;
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    isButtonActive.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            80.vGap,
            Text(
              AppStrings.createAccount,
              style: getSemiBoldStyle(
                fontSize: FontSize.s28,
              ).copyWith(fontFamily: FontConstants.fontMontserratFamily),
            ),
            34.vGap,
            SignUpUserAcceptData(
              usernameController: usernameController,
              emailController: emailController,
              phoneController: phoneController,
              passwordController: passwordController,
              confirmPassController: confirmPassController,
              onCountryChanged: (country) {
                if (countryCode != country.dialCode) {
                  setState(() {
                    countryCode = country.dialCode;
                  });
                  log('Country code changed to: $countryCode');
                }
              },
            ),
            15.vGap,
            const RegisterAgreementText(),
            15.vGap,
            ValueListenableBuilder<bool>(
              valueListenable: isButtonActive,
              builder: (context, isActive, child) {
                return CustomElevatedButton(
                  textButton: AppStrings.signUp,
                  onPressed: !isActive
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            if (passwordController.text ==
                                confirmPassController.text) {
                              userRegister(context, countryCode);
                            } else {
                              passNotTheSame(context);
                            }
                          }
                        },
                );
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
      ),
    );
  }

  Future<void> userRegister(BuildContext context, dynamic country) async {
    BlocProvider.of<RegisterCubit>(context).context = context;
    await BlocProvider.of<RegisterCubit>(context).register(
        registerRequest: RegisterRequest(
            email: emailController.text,
            password: passwordController.text,
            userName: usernameController.text,
            phoneNumber: '+$country${phoneController.text}'));
  }
}
