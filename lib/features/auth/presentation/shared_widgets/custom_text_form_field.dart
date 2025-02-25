import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final IconData? iconData;
  final TextInputType inputType;
  final TextEditingController controller;
  final bool? isShowDescription, isAcceptNumbersOnly;
  final bool? isUsedWithBidOwner;
  final String? Function(String?)? validator;

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
    this.isAcceptNumbersOnly,
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
      controller: widget.controller,
      maxLines: widget.isShowDescription == true ? null : 1,
      keyboardType: widget.inputType,
      style: getRegularStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s16,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return AppStrings.fieldRequired;
        }
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        return null;
      },
      inputFormatters: [
        if (widget.isAcceptNumbersOnly == true)
          FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.labelText,
        hintText: widget.hintText,
        contentPadding: widget.isShowDescription == true
            ? (_isEmpty
                ? const EdgeInsets.symmetric(vertical: 50, horizontal: 20)
                : const EdgeInsets.all(20))
            : const EdgeInsets.all(20),
        prefixIconColor: ColorManager.lightGrey,
        prefixIcon: widget.iconData != null
            ? Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Icon(
                  widget.iconData,
                  size: 28.sp,
                ),
              )
            : null,
      ),
    );
  }
}
