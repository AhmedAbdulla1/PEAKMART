
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';

import '../../../data/page_view_content.dart';
import 'custom_text_widget.dart';
import 'package:flutter/material.dart';

class OnboardingTitleAndDescSection extends StatelessWidget {
  const OnboardingTitleAndDescSection({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextWidget(
            text: onboardingList[index].title,
            style: getBoldStyle(
              fontSize: FontSize.s24,
              color: ColorManager.black,
            )),
        const SizedBox(
          height: 10,
        ),
        CustomTextWidget(
            text: onboardingList[index].description,
            style: getMediumStyle(
              fontSize: FontSize.s14,
              color: ColorManager.grey2,
            ).copyWith(fontFamily: FontConstants.fontMontserratFamily)),
      ],
    );
  }
}
