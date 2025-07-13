
import 'package:flutter/material.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';

class CustomTextRow extends StatelessWidget {
  const CustomTextRow({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: getBoldStyle(
            fontSize: FontSize.s20,
          ),
        ),
        Text(
          value,
          style: getRegularStyle(fontSize: FontSize.s20),
        ),
      ],
    );
  }
}
