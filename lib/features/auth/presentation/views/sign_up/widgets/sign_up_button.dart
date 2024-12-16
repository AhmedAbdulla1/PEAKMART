import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';

class SignUpButton extends StatefulWidget {
  const SignUpButton({super.key, this.onPressed});

  final void Function()? onPressed;
  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.simiBlue,
        minimumSize:  Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppPadding.p10),
        ),
      ),
      child:  FittedBox(
        child: Text(
          AppStrings.signUp
        ),
      ),
    );
  }
}
