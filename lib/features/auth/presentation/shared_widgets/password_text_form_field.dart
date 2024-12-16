import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
  });
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

bool isPressed = false;

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool isValidPassword = false; // Track password validity

  // Function to validate password
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'This field is required.';
    }

    // Check if the password meets the required conditions
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number.';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          style: getRegularStyle(
            color: ColorManager.primary,
            fontSize: FontSize.s16,
          ),
          obscureText: isPressed ? false : true,
          validator: (value) =>
              validatePassword(value!), 
          decoration: InputDecoration(
            hintText: widget.hintText,
            labelText: widget.labelText,
            prefixIconColor: ColorManager.lightGrey,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: AppPadding.p5),
              child: Icon(
                Icons.lock,
                size: 28.sp,
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: isPressed
                    ? const Icon(
                        Icons.visibility,
                      )
                    : const Icon(
                        Icons.visibility_off,
                      ),
                onPressed: () {
                  setState(() {
                    isPressed = !isPressed;
                  });
                },
                iconSize: 28.sp,
              ),
            ),
            suffixIconColor: ColorManager.lightGrey,
          ),
        ),
      ],
    );
  }
}
