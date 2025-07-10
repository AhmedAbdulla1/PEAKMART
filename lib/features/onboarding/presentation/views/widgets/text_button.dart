import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';

import '../../../../../core/resources/style_manager.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: getBoldStyle(
            fontSize: FontSize.s18,
            color: context.isDarkMode
                ? ColorManager.darkModePrimary
                : ColorManager.primary),
      ),
    );
  }
}

class GetStart extends StatelessWidget {
  final VoidCallback? onPressed;

  const GetStart({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        'Get Start',
        style: getBoldStyle(
            fontSize: FontSize.s18,
            color: context.isDarkMode
                ? ColorManager.darkModePrimary
                : ColorManager.primary),
      ),
    );
  }
}
