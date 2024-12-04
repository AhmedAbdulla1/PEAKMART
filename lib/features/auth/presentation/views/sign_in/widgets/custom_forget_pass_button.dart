import 'package:flutter/material.dart';
import 'package:peakmart/app/resources/color_manager.dart';
import 'package:peakmart/app/resources/font_manager.dart';
import 'package:peakmart/app/resources/routes_manager.dart';
import 'package:peakmart/app/resources/style_manager.dart';

class CustomForgetPassButton extends StatelessWidget {
  const CustomForgetPassButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.forgetPasswordScreen);
        },
        child: Text(
          'Forgot Password?',
        ),
      ),
    );
  }
}
