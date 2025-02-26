import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';

class OtherLoginMethodsShape extends StatelessWidget {
  const OtherLoginMethodsShape({
    super.key,
    this.onTap,
    this.isLoading,
  });
  final void Function()? onTap;
  final bool? isLoading;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p5),
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: ColorManager.textFormBackground,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorManager.primary, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          splashColor: const Color(0xffFCF3F6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40, vertical:  AppPadding.p10),
            child: Center(
              child: isLoading == true
                  ? const WaitingWidget()
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          IconsAssets.googleIcon,
                        ),
                        18.hGap,
                        Text(AppStrings.google,
                            style: getRegularStyle(
                                fontSize: FontSize.s16,
                                color: ColorManager.grey1)),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
