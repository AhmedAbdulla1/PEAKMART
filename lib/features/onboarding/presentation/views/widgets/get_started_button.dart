

import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';


class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        // await completeOnboardingView();
        // ignore: use_build_context_synchronously
        
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:ColorManager.red,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: FittedBox(
        child: Text(
          'Get Started',
          style:  getMediumStyle(fontSize: FontSize.s18, color:  ColorManager.starActive,)
        ),
      ),
    );
  }


}
