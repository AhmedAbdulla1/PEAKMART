import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/features/auth/presentation/shared_widgets/enter_listener_widget.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.suffixIcon,
    this.onChanged,
    required this.prefixIcon,
    this.isMultiLine,
  });

  final TextEditingController controller;
  final String label;
  final Function(String)? onChanged;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final bool? isMultiLine;

  @override
  Widget build(BuildContext context) {
    return EnterListener(
      onEnter: () {
        FocusScope.of(context).nextFocus();
      },
      child: TextField(
        maxLines: isMultiLine == true ? 2 : 1,
        style: getRegularStyle(
          fontSize: FontSize.s14,
          color: context.primaryColor
             
        ),
        controller: controller,
        decoration: InputDecoration(
          prefixIconColor: ColorManager.textFormIcon,
          prefixIcon: Icon(prefixIcon),
          suffixIconColor: ColorManager.textFormIcon,
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          labelText: label,
        ),
        onChanged: onChanged,
        textInputAction: TextInputAction.next,
        onSubmitted: (_) =>
            FocusScope.of(context).nextFocus(), // مهم جدًا للموبايل
      ),
    );
  }
}
