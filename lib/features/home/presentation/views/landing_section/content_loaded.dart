import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/view.dart';
import 'package:peakmart/features/home/domain/entity/content_entity.dart';

class ContentLoadedWidget extends StatelessWidget {
  const ContentLoadedWidget({
    super.key,
    required ContentData? contentData,
    required this.buttonText,
  }) : _contentData = contentData;

  final ContentData? _contentData;
  final String buttonText;

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
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(_contentData!.image["background"]),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(
                right: 0,
                child:
                    Image.network(_contentData!.image["image"], height: 125.w)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 240,
                  child: Text(
                    _contentData!.content,
                    softWrap: true,
                    style: getBoldStyle(
                        fontSize: FontSize.s17, color: ColorManager.primary),
                  ),
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
          ],
        ),
      ),
    );
  }
}
