import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const  EdgeInsets.symmetric(horizontal: AppPadding.p22,vertical: AppPadding.p10),
      child: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(IconsAssets.arrowBack),
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: BorderSide(color: ColorManager.grey2),
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style:
              getSemiBoldStyle(fontSize: FontSize.s18, color: ColorManager.black),
        ),
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(56.0); // Default AppBar height
}
