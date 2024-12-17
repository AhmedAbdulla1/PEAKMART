import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/sign_up_view.dart';

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
          style: getMediumStyle(
              fontSize: FontSize.s15, color: ColorManager.darkGrey),
        ),
        TextButton(
          onPressed: () {
            if (textButton == AppStrings.signUp) {
              Navigator.pushNamed(context, SignUpView.routeName);
            } else if (textButton == 'Login') {
              Navigator.pop(context);
            }
          },
          child: Text(textButton,
              style: getBoldStyle(
                fontSize: FontSize.s16,
                color: ColorManager.primary,
              ).copyWith(
                decoration: TextDecoration.underline,
              )),
        ),
      ],
    );
  }
}
