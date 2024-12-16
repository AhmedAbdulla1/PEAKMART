import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData iconData;
  final TextInputType inputType;
  final TextEditingController controller;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.iconData,
    required this.inputType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: getRegularStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s16,
      ),
      keyboardType: inputType,
      autovalidateMode:
          AutovalidateMode.onUserInteraction, 
      validator: (value) {
        if (hintText == 'Enter your email') {
          if (value == null || value.isEmpty) {
            return 'This field is required.';
          }
          String pattern =
              r'^[a-zA-Z][a-zA-Z0-9._%+-]*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
          RegExp regex = RegExp(pattern);
          if (value.isEmpty) {
            return 'Please enter an email address';
          } else if (!regex.hasMatch(value)) {
            return 'Please enter a valid email address';
          }
        }
        if (value == null || value.isEmpty) {
          return 'This field is required.';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIconColor: ColorManager.lightGrey,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Icon(
            iconData,
            size: 28.sp,
          ),
        ),
      ),
    );
  }
}
