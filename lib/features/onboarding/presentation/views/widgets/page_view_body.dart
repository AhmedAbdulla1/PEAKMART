import 'package:Bid_Mart/core/resources/theme/app_theming_cubit/app_theme_cubit.dart';
import 'package:Bid_Mart/core/shared_widgets/change_theme_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Bid_Mart/app/app_prefs.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/features/auth/presentation/views/login/login_view.dart';
import 'package:Bid_Mart/features/onboarding/presentation/views/widgets/text_button.dart';
import 'package:Bid_Mart/features/onboarding/presentation/views/widgets/skip_text_button.dart';
import 'package:Bid_Mart/features/onboarding/presentation/views/widgets/text_button.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<AppThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                final bool isDarkThemeActive = themeMode == ThemeMode.dark ||
                    (themeMode == ThemeMode.system &&
                        MediaQuery.of(context).platformBrightness ==
                            Brightness.dark);

                return CustomChangeThemeWidget(
                  onPressed: () {
                    context.read<AppThemeCubit>().changeTheme(
                        isDarkThemeActive ? ThemeMode.light : ThemeMode.dark);
                  },
                );
              },
            ),
            SkipTextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, LogInView.routeName);
                _appPreferences.setPressKeyOnBoardingScreen();
              },
            ),
          ],
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
            Visibility(
              visible: widget.index != 0,
              child: CustomTextButton(
                  title: "Back",
                  onPressed: () {
                    setState(() {
                      widget.index -= 1;
                    });
                  }),
            ),
            PageChangePoints(currentIndex: widget.index),
            widget.index != 3
                ? CustomTextButton(
                    title: "Next",
                    onPressed: () {
                      setState(() {
                        widget.index += 1;
                      });
                    })
                : GetStart(
                    onPressed: () {
                      _appPreferences.setPressKeyOnBoardingScreen();
                      Navigator.pushReplacementNamed(
                          context, LogInView.routeName);
                    },
                  ),
          ],
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
