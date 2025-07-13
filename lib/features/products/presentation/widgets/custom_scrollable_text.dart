import 'package:flutter/material.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/values_manager.dart';

class CustomScrollableText extends StatelessWidget {
  const CustomScrollableText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      padding: const EdgeInsets.all(AppPadding.p12),
      decoration: BoxDecoration(
        color: ColorManager.darkGrey.withOpacity(.05),
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Text(
            text,
            textAlign: TextAlign.start,
            style: getRegularStyle(
              fontSize: FontSize.s17,
            ),
          ),
        ),
      ),
    );
  }
}
