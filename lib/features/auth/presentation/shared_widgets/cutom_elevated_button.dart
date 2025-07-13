import 'package:flutter/material.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.textButton,
    this.onPressed,
    this.minimumSize,
  });
  final String textButton;
  final void Function()? onPressed;
  final Size? minimumSize;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        minimumSize: minimumSize,
      ),
      child: Text(
        textButton,
        style: getBoldStyle(
            fontSize: FontSize.s20,
            color:
                onPressed == null ? ColorManager.primary : ColorManager.white),
      ),
    );
  }
}
