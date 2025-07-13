import 'package:flutter/material.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';

class BuildTitleWidget extends StatelessWidget {
  const BuildTitleWidget({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: getBoldStyle(
        fontSize: FontSize.s20,
        color: context.primaryColor,
      ),
    );
  }
}