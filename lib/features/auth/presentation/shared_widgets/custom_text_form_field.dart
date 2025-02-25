import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/validators.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData? iconData;
  final TextInputType inputType;
  final TextEditingController controller;
  final bool? isShowDescription;
  final bool? isUsedWithBidOwner;
  final String? Function(String?)? validator;
  final Function(String)?  onChanged;
  final List<TextInputFormatter>? inputFormatter ;
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.iconData,
    required this.inputType,
    required this.controller,
    this.isShowDescription,
    this.isUsedWithBidOwner,
    this.validator,
    this.onChanged,
    this.inputFormatter,
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
      inputFormatters: inputFormatter,
      onChanged: onChanged,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        }
        if (hintText == AppStrings.emailHint) {
          return Validator.validateEmail(value!);
        }
        if (hintText == AppStrings.userNameHint) {
          return Validator.validateUserName(value!);
        }
        if (value == null || value.isEmpty) {
          return AppStrings.fieldRequired;
        }
        return null;
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
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

      )
    );
  }
}
