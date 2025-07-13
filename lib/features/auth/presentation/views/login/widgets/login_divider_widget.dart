import 'package:flutter/material.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';

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
          style: getMediumStyle(
            fontSize: FontSize.s12,
          ),
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
