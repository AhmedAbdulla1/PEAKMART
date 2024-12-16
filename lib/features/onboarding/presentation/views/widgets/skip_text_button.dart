import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/auth/presentation/views/login/login_view.dart';

class SkipTextButton extends StatefulWidget {
  const SkipTextButton({
    super.key,
  });

  @override
  State<SkipTextButton> createState() => _SkipTextButtonState();
}

class _SkipTextButtonState extends State<SkipTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        setState(
          () {
            Navigator.pushNamed(context,LogInView.routeName);
          },
        );
      },
      child: Text(
        'Skip',
        style: getBoldStyle(fontSize: FontSize.s18, color: ColorManager.black),
      ),
    );
  }
}
