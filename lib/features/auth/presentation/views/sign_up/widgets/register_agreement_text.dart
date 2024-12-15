

import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';

class RegisterAgreementText extends StatelessWidget {
  const RegisterAgreementText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'By clicking the',
            style: getRegularStyle(
              fontSize: FontSize.s15,
              color: const Color(0xff676767),
            ),
          ),
          TextSpan(
            text: ' Register ',
            style: getRegularStyle(
                fontSize: FontSize.s15, color: ColorManager.primary),
          ),
          TextSpan(
            text: 'button, you agree to the public offer',
            style: getRegularStyle(
              fontSize: FontSize.s15,
              color: const Color(0xff676767),
            ),
          )
        ],
      ),
    );
  }
}
