import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Bid_Mart/core/resources/assets_manager.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/string_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/core/resources/values_manager.dart';
import 'package:Bid_Mart/core/widgets/waiting_widget.dart';

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
        color: context.colorScheme.surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorManager.primary, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          splashColor: const Color(0xffFCF3F6),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p40, vertical: AppPadding.p10),
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
                            )),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
