import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/view.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  final String title = "Get the deal of a lifetime...";
  final String subtitle = "Join and start bidding!";
  final String buttonText = "Join Now";

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppPadding.p20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 4.0,
      child: Container(
        padding: const EdgeInsetsDirectional.only(
          start: AppPadding.p30,
          top: AppPadding.p20,
          bottom: AppPadding.p14,
        ),
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageAssets.landingBg), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: getBoldStyle(
                  fontSize: FontSize.s17, color: ColorManager.primary),
            ),
            Text(
              subtitle,
              style: getBoldStyle(
                  fontSize: FontSize.s17, color: ColorManager.primary),
            ),
            SizedBox(height: AppSize.s40.h),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, SignUpForBidView.routeName);
              },
              child: Text(
                buttonText,
                style: getBoldStyle(
                    fontSize: FontSize.s17, color: ColorManager.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
