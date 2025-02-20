import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';

import '../../../../../core/resources/style_manager.dart';

class NextTextButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const NextTextButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        'Next',
        style:
            getBoldStyle(fontSize: FontSize.s18, color: ColorManager.primary),
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
        style:
        getBoldStyle(fontSize: FontSize.s18, color: ColorManager.primary),
      ),
    );
  }
}

