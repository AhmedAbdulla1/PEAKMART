import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/features/auth/presentation/views/login/login_view.dart';
import 'package:peakmart/features/onboarding/presentation/views/widgets/text_button.dart';
import 'package:peakmart/features/onboarding/presentation/views/widgets/skip_text_button.dart';

import '../../../data/page_view_content.dart';
import 'onboarding_title_and_descr_sectiont.dart';
import 'page_change_point.dart';

// ignore: must_be_immutable
class PageViewBody extends StatefulWidget {
  PageViewBody({super.key, required this.index});

  int index;

  @override
  State<PageViewBody> createState() => _PageViewBodyState();
}

class _PageViewBodyState extends State<PageViewBody> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 25.h),
        Align(
          alignment: Alignment.centerRight,
          child: SkipTextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, LogInView.routeName);
              _appPreferences.setPressKeyOnBoardingScreen();
            },
          ),
        ),
        const Spacer(),
        Image.asset(
          onboardingList[widget.index].image,
        ),
        SizedBox(height: 12.h),
        OnboardingTitleAndDescSection(index: widget.index),
        const Spacer(
          flex: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .1,
            ),
            PageChangePoints(currentIndex: widget.index),
           widget.index != 3 ?  NextTextButton(onPressed: () {
              setState(() {
                widget.index += 1;
              });
            }):
            GetStart(
              onPressed: () {
                _appPreferences.setPressKeyOnBoardingScreen();
                Navigator.pushReplacementNamed(context, LogInView.routeName);
              },
            ),
          ],
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
