import 'package:flutter/material.dart';
import 'package:peakmart/app/resources/color_manager.dart';
import 'package:peakmart/app/resources/font_manager.dart';
import 'package:peakmart/app/resources/style_manager.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.buttonText});
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        buttonText,
        style: getBoldStyle(
          fontSize: FontSize.s18,
          color: ColorManager.white,
        ).copyWith(
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}
