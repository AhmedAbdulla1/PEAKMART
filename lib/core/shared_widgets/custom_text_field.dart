import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.suffixIcon,
      this.onChanged,
      required this.prefixIcon,
      this.isMultiLine});
  final TextEditingController controller;
  final String label;
  final Function(String)? onChanged;
  final IconData prefixIcon;
  final IconData? suffixIcon ;
  final bool? isMultiLine;

  @override
  Widget build(BuildContext context) {
    return TextField(
        maxLines: isMultiLine == true ? 2 : 1,
        style: getRegularStyle(
            fontSize: FontSize.s14,
            color: context.isDarkMode
                ? ColorManager.darkModePrimary
                : ColorManager.primary),
        controller: controller,
        decoration: InputDecoration(
          prefixIconColor: ColorManager.textFormIcon,
          prefixIcon: Icon(prefixIcon),
          suffixIconColor: ColorManager.textFormIcon,
          suffixIcon: Icon(suffixIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          labelText: label,
        ),
        onChanged: onChanged);
  }
}
