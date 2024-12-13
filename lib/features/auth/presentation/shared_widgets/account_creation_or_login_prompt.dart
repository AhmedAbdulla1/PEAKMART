import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/routes_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';

class AccountCreationOrLoginPrompt extends StatelessWidget {
  const AccountCreationOrLoginPrompt(
      {super.key, required this.text, required this.textButton});
  final String text;
  final String textButton;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: getRegularStyle(
              fontSize: FontSize.s15, color: ColorManager.lightGrey),
        ),
        TextButton(
          onPressed: () {
            if (textButton == 'Sign Up') {
              Navigator.pushNamed(context, Routes.signUpScreen);
            } else if (textButton == 'Login') {
              Navigator.pop(context);
            }
          },
          child: Text(
            textButton,
            style: getBoldStyle(
                fontSize: FontSize.s14,
                color: ColorManager.primary,).copyWith(
              decoration: TextDecoration.underline,
              // fontFamily: FontConstants.fontMontserratFamily
            )
          ),
        ),
      ],
    );
  }
}
