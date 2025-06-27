import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/otp_verification.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/hold_screen.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/view.dart';
import 'package:peakmart/features/home/domain/entity/content_entity.dart';

class ContentLoadedWidget extends StatelessWidget {
  const ContentLoadedWidget({
    super.key,
    required this.contentData,
    required this.buttonText,
  });

  final ContentData contentData;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.isDarkMode ? ColorManager.black : ColorManager.white,
      margin: const EdgeInsets.all(AppPadding.p20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: Container(
        padding: const EdgeInsetsDirectional.only(
          start: AppPadding.p30,
          top: AppPadding.p20,
          bottom: AppPadding.p14,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          image: contentData.image['background']!.isEmpty
              ? null
              : DecorationImage(
                  image: NetworkImage(contentData.image['background']!),
                  fit: BoxFit.cover,
                ),
        ),
        child: Stack(
          children: [
            // Foreground image with Skeleton.replace
            Positioned(
              right: 0,
              child: Skeleton.replace(
                child: contentData.image['image']!.isEmpty
                    ? const SizedBox()
                    : Image.network(
                        contentData.image['image']!,
                        height: 125.w,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error, size: 50),
                      ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 240,
                  child: Text(
                    contentData.content,
                    softWrap: true,
                    style: getBoldStyle(
                      fontSize: FontSize.s17,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
                SizedBox(height: AppSize.s40.h),
                ElevatedButton(
                  onPressed: () {
                    print('${instance<AppPreferences>().getCookie("HKHN")}');
                    if (instance<AppPreferences>().getCookie("HKH") != '') {
                      Navigator.pushNamed(context, HoldScreen.routeName);
                    } else if (instance<AppPreferences>().getCookie("HKHN") !=
                        '') {
                      Navigator.pushNamed(
                        context,
                        SignUpForBidView.routeName,
                        arguments: 1,
                      );
                    } else if (instance<AppPreferences>().getCookie("PHONE") !=
                        '') {
                      Navigator.pushNamed(
                        context,
                        OtpVerification.routeName,
                        arguments: {
                          'verificationType': VerificationType.watsApp,
                        },
                      );
                    } else {
                      Navigator.pushNamed(
                        context,
                        SignUpForBidView.routeName,
                        arguments: 0,
                      );
                    }
                  },
                  child: Text(
                    buttonText,
                    style: getBoldStyle(
                      fontSize: FontSize.s17,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
