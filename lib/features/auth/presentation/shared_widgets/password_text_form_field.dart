import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/validators.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.validator,
  });
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          style: getRegularStyle(
            color: context.isDarkMode
                ? ColorManager.darkModePrimary
                : ColorManager.primary,
            fontSize: FontSize.s16,
          ),
          obscureText: isPressed ? false : true,
          validator: (value) {
            if (widget.validator != null) {
              return widget.validator!(value);
            }
            return Validator.validatePassword(value!);
          },
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
              padding: const EdgeInsets.only(right: AppPadding.p10),
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
