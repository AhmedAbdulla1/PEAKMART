import 'package:flutter/material.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';

class NoProductsFoundedWidget extends StatelessWidget {
  const NoProductsFoundedWidget(
      {super.key,
      required this.title,
      required this.buttonText,
      this.onButtonPressed});
  final String title, buttonText;
  final void Function()? onButtonPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 50,
          color: ColorManager.red,
        ),
        20.vGap,
        Text(
          title,
          style: getMediumStyle(fontSize: 26),
        ),
        20.vGap,
        ElevatedButton(onPressed: onButtonPressed, child: Text(buttonText)),
      ],
    );
  }
}
