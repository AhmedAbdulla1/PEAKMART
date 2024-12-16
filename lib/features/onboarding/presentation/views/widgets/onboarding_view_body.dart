import 'package:flutter/material.dart';

import 'page_view_body.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

int currentIndex = 0;
PageController pageController = PageController();

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 4,
      physics: const BouncingScrollPhysics(),
      controller: pageController,
      onPageChanged: (value) {
        setState(
          () {
            currentIndex = value;
          },
        );
      },

      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: PageViewBody(index: index));
      },
    );
  }
}
