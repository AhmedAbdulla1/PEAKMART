import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/core/resources/values_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle,
    this.isNotShowArrowBack = false,
  });

  final String title;
  final List<Widget>? actions;
  final bool? centerTitle, isNotShowArrowBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p22,
        vertical: AppPadding.p10,
      ),
      child: AppBar(
        shadowColor: context.colorScheme.shadow,
        backgroundColor: context.colorScheme.background,
        elevation: 0,
        forceMaterialTransparency: true,
        leading: isNotShowArrowBack!
            ? null
            : IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(
                  IconsAssets.arrowBack,
                  color: context.colorScheme.onBackground,
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(color: context.colorScheme.outline),
                    ),
                  ),
                ),
              ),
        leadingWidth: isNotShowArrowBack! ? null : 50.w,
        title: Text(
          title,
          style: getSemiBoldStyle(
            fontSize: FontSize.s20,
            color: context.colorScheme.onBackground,
          ),
        ),
        centerTitle: centerTitle ?? true,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
