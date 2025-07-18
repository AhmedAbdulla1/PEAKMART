import 'package:Bid_Mart/core/resources/assets_manager.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle,
    this.isNotShowArrowBack = false,
    this.bottomWidget,
    this.onBackPressed,
  });
  final void Function()? onBackPressed;
  final String title;
  final List<Widget>? actions;
  final bool? centerTitle, isNotShowArrowBack;
  final PreferredSizeWidget? bottomWidget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p22,
        vertical: AppPadding.p10,
      ),
      child: AppBar(
        shadowColor: context.colorScheme.shadow,
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        leading: isNotShowArrowBack!
            ? null
            : IconButton(
                onPressed: onBackPressed ?? () => Navigator.pop(context),
                icon: SvgPicture.asset(
                  IconsAssets.arrowBack,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
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
            color: context.colorScheme.onSurface,
          ),
        ),
        centerTitle: centerTitle ?? true,
        actions: actions,
        bottom: bottomWidget,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(bottomWidget != null ? 100.h : 56.h);
}
