import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';

class SkipTextButton extends StatelessWidget {
  const SkipTextButton({super.key, required this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,

      //     () {
      //       Navigator.pushNamed(context,LogInView.routeName);
      //   // setState(
      //   //   () {
      //     // },
      //   // );
      // },
      child: Text(
        'Skip',
        style: getBoldStyle(
          fontSize: FontSize.s18,
          color: context.isDarkMode ? ColorManager.white : ColorManager.black,
        ),
      ),
    );
  }
}
