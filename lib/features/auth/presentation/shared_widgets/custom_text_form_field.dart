import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/validators.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final IconData? prefixIcon;
  final IconButton? suffixIcon;
  final TextInputType inputType;
  final TextEditingController controller;
  final bool? isShowDescription;
  final bool? isUsedWithBidOwner;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatter;
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.inputType,
    required this.controller,
    this.isShowDescription,
    this.isUsedWithBidOwner,
    this.validator,
    this.onChanged,
    this.inputFormatter,
    this.onTap,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _isEmpty = widget.controller.text.isEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      controller: widget.controller,
      maxLines: widget.isShowDescription == true ? 5 : 1,
      keyboardType: widget.inputType,
      style: getRegularStyle(
        color: context.isDarkMode
            ? ColorManager.darkModePrimary
            : ColorManager.primary,
        fontSize: FontSize.s16,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        if (widget.hintText == AppStrings.emailHint) {
          return Validator.validateEmail(value!);
        }
        if (widget.hintText == AppStrings.userNameHint) {
          return Validator.validateUserName(value!);
        }
        if (value == null || value.isEmpty) {
          return AppStrings.fieldRequired;
        }
        return null;
      },
      inputFormatters: widget.inputFormatter,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        FocusScope.of(context).nextFocus();
      },
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.labelText,
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.all(20),
        prefixIconColor: ColorManager.lightGrey,
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Icon(
                  widget.prefixIcon,
                  size: 28.sp,
                ),
              )
            : null,
        suffixIcon: widget.suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: widget.suffixIcon,
              )
            : null,
      ),
    );
  }
}
