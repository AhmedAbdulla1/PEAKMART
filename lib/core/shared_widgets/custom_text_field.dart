
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
      this.onChanged,
      required this.icon});
  final TextEditingController controller;
  final String label;
  final Function(String)? onChanged;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextField(
        style: getRegularStyle(
            fontSize: FontSize.s14,
            color: context.isDarkMode
                ? ColorManager.darkModePrimary
                : ColorManager.primary),
        controller: controller,
        decoration: InputDecoration(
          prefixIconColor: ColorManager.textFormIcon,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          labelText: label,
        ),
        onChanged: onChanged);
  }
}
