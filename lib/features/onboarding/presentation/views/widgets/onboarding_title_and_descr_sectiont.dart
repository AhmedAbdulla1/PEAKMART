import 'package:flutter/material.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';

import '../../../data/page_view_content.dart';
import 'custom_text_widget.dart';

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
            )),
        const SizedBox(
          height: 10,
        ),
        CustomTextWidget(
            text: onboardingList[index].description,
            style: getMediumStyle(
              fontSize: FontSize.s14,
              color:
                  context.isDarkMode ? ColorManager.grey : ColorManager.grey2,
            ).copyWith(fontFamily: FontConstants.fontMontserratFamily)),
      ],
    );
  }
}
