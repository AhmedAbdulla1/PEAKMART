import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      required this.title,
      this.actions,
      this.centerTitle,
      this.isNotShowArrowBack = false});
  final String title;
  final List<Widget>? actions;
  final bool? centerTitle, isNotShowArrowBack;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p22, vertical: AppPadding.p10),
      child: AppBar(
        shadowColor: ColorManager.white,
        foregroundColor: ColorManager.white,
        surfaceTintColor: ColorManager.white,
        backgroundColor: ColorManager.white,
        elevation: 0,
        forceMaterialTransparency: true,
        leading: isNotShowArrowBack == false
            ? Center(
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
              )
            : const SizedBox(
                width: 1,
                height: 1,
              ),
        leadingWidth: isNotShowArrowBack == true ? 0 : 50.w,
        title: Text(
          title,
          style: getSemiBoldStyle(
              fontSize: FontSize.s20, color: ColorManager.black),
        ),
        centerTitle: centerTitle ?? true,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(56.0); // Default AppBar height
}
// AppBar(
//         centerTitle: false,
//         title: Text("My Products",
//             style: getBoldStyle(
//                 fontSize: FontSize.s24, color: ColorManager.black)),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: IconButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, BidOwnerView.routeName);
//               },
//               tooltip: "Add Product",
//               icon: const Icon(
//                 Icons.add,
//                 color: ColorManager.white,
//               ),
//               style:
//                   IconButton.styleFrom(backgroundColor: ColorManager.primary),
//             ),
//           ),
//         ],
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),

