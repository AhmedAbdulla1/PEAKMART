import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';

class CustomChangeThemeWidget extends StatefulWidget {
  const CustomChangeThemeWidget({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  State<CustomChangeThemeWidget> createState() =>
      _CustomChangeThemeWidgetState();
}

class _CustomChangeThemeWidgetState extends State<CustomChangeThemeWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        backgroundColor:
            !context.isDarkMode ? ColorManager.white : ColorManager.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.sp),
        ),
        side: BorderSide(
          color: context.isDarkMode ? ColorManager.white : ColorManager.black,
          width: 3.w,
        ),
        minimumSize: Size(70.sp, 36.sp),
        maximumSize: Size(70.sp, 36.sp),
      ),
      child: context.isDarkMode
          ? Row(
              children: [
                const Spacer(),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(
                    Icons.dark_mode_outlined,
                    color: context.isDarkMode
                        ? ColorManager.white
                        : ColorManager.black,
                  ),
                ),
              ],
            )
          : Row(
              children: [
                FittedBox(
                  fit: BoxFit.fill,
                  child: Icon(
                    Icons.light_mode_outlined,
                    color: context.isDarkMode
                        ? ColorManager.white
                        : ColorManager.black,
                  ),
                ),
                const Spacer(),
              ],
            ),
    );
  }
}
