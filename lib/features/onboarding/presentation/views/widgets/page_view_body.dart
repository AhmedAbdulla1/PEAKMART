import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/features/auth/presentation/views/login/login_view.dart';
import 'package:peakmart/features/onboarding/presentation/views/widgets/next_text_button.dart';
import 'package:peakmart/features/onboarding/presentation/views/widgets/skip_text_button.dart';

import '../../../data/page_view_content.dart';
import 'onboarding_title_and_descr_sectiont.dart';
import 'page_change_point.dart';

class PageViewBody extends StatefulWidget {
  PageViewBody({super.key, required this.index});
  int index;

  @override
  State<PageViewBody> createState() => _PageViewBodyState();
}

class _PageViewBodyState extends State<PageViewBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 25.h),
        const Align(alignment: Alignment.centerRight, child: SkipTextButton()),
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
            NextTextButton(onPressed: () {
              setState(() {
                widget.index == 3
                  ? Navigator.pushNamed(context, LogInView.routeName)
                  : widget.index += 1;
              });
            }),
          ],
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
