import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';

import 'onboarding_view_body.dart';

class PageChangePoints extends StatelessWidget {
  const PageChangePoints({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => GestureDetector(
          onTap: () {
            if (index != currentIndex) {
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            }
          },
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            width: currentIndex == index ? 40 : 10,
            height: 8,
            decoration: BoxDecoration(
              color: currentIndex == index
                  ? context.isDarkMode
                      ? ColorManager.darkModePrimary
                      : ColorManager.black
                  : ColorManager.grey2,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}
