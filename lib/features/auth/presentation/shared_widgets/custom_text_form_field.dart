import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData? iconData;
  final TextInputType inputType;
  final TextEditingController controller;
  final bool? isShowDescription;
  final bool? isUsedWithBidOwner;
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.iconData,
    required this.inputType,
    required this.controller,
    this.isShowDescription,
    this.isUsedWithBidOwner,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: isShowDescription == true ? null : 1,
      keyboardType: inputType,
      style: getRegularStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s16,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (hintText == AppStrings.emailHint) {
          if (value == null || value.isEmpty) {
            return AppStrings.fieldRequired;
          }
          String pattern =
              r'^[a-zA-Z][a-zA-Z0-9._%+-]*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
          RegExp regex = RegExp(pattern);
          if (value.isEmpty) {
            return AppStrings.enterEmail;
          } else if (!regex.hasMatch(value)) {
            return AppStrings.emailError;
          }
        }
        if (hintText == AppStrings.userNameHint) {
          if (value == null || value.isEmpty) {
            return AppStrings.fieldRequired;
          }

          String pattern = r'^[a-zA-Z\s]+$';
          RegExp regex = RegExp(pattern);
          if (!regex.hasMatch(value)) {
            return AppStrings.nameError;
          }
        }
        if (value == null || value.isEmpty) {
          return AppStrings.fieldRequired;
        }
        return null;
      },
      decoration: InputDecoration(
        floatingLabelBehavior: isUsedWithBidOwner == true
            ? FloatingLabelBehavior.never
            : FloatingLabelBehavior.always,
        labelText: labelText,
        hintText: hintText,
        contentPadding: isShowDescription == true
            ? const EdgeInsets.only(top: AppPadding.p100, left: AppPadding.p20)
            : const EdgeInsets.all(AppPadding.p20),
        prefixIconColor: ColorManager.lightGrey,
        prefixIcon: iconData != null
            ? Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Icon(
                  iconData,
                  size: 28.sp,
                ),
              )
            : null,
        alignLabelWithHint: true,
      ),
    );
  }
}
