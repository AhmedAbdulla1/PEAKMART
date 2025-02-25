import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/shared_widgets/text_fields.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_text_form_field.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/password_text_form_field.dart';

class SignUpUserAcceptData extends StatefulWidget {
  const SignUpUserAcceptData({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPassController,
    required this.onCountryChanged,
  });

  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPassController;
  final Function(Country)? onCountryChanged;
  @override
  State<SignUpUserAcceptData> createState() => _SignUpUserAcceptDataState();
}

class _SignUpUserAcceptDataState extends State<SignUpUserAcceptData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextFormField(
          labelText: AppStrings.userName,
          hintText: AppStrings.userNameHint,
          iconData: Icons.person,
          controller: widget.usernameController,
          inputType: TextInputType.name,
        ),
        SizedBox(height: 25.h),
        CustomTextFormField(
          labelText: AppStrings.email,
          hintText: AppStrings.emailHint,
          iconData: Icons.email,
          controller: widget.emailController,
          inputType: TextInputType.emailAddress,
        ),
        SizedBox(height: 25.h),

        CustomPhoneTextField(
          controller: widget.phoneController,
          onCountryChanged: widget.onCountryChanged,
        ),
        SizedBox(height: 10.h),
        PasswordTextFormField(
          labelText: AppStrings.password,
          hintText: AppStrings.passwordHint,
          controller: widget.passwordController,
        ),
        SizedBox(height: 25.h),
        PasswordTextFormField(
          labelText: AppStrings.confirmPassword,
          hintText: AppStrings.confirmPasswordHint,
          controller: widget.confirmPassController,
        ),
        //  CustomFormW(
        //   numberOfFields: 3,
        //   requiredFieldIndices: [1, 2],
        //   labelText: ['Name', 'Email', 'Phone'],
        //   onSubmit: () {
        //     print('Form submitted');
        //   },
        //   //for email validation , password length validation and phone number validation
        //   keyboardType: [
        //           TextInputType.text,
        //           TextInputType.emailAddress,
        //           TextInputType.phone,
        //           TextInputType.visiblePassword,
        //           TextInputType.visiblePassword,
        //           TextInputType.text,
        //           TextInputType.text,
        //         ],
        // ),
      ],
    );
  }
}
