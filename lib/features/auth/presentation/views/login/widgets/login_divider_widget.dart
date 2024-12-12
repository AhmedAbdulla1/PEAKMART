import 'package:flutter/material.dart';
import 'package:peakmart/app/resources/color_manager.dart';
import 'package:peakmart/app/resources/font_manager.dart';
import 'package:peakmart/app/resources/style_manager.dart';

class LoginDividerWidget extends StatelessWidget {
  const LoginDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: ColorManager.primary,
          ),
        ),
        Text(
          '  Or Continue with  ',
          style:
              getMediumStyle(fontSize: FontSize.s12, color: ColorManager.grey2),
        ),
        Expanded(
          child: Divider(
            color: ColorManager.primary,
          ),
        ),
      ],
    );
  }
}
