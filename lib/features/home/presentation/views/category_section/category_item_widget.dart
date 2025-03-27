import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/home/domain/entity/category_entity.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget(
      {super.key,
      required this.category,
      required this.onTap,
      this.isSelected = false});

  final CategoryEntity category;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 8.0),
      child: InkWell(
        radius: 30,
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 50,
          ),
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p5),
            decoration: BoxDecoration(
              color:
                  context.isDarkMode ? ColorManager.black : ColorManager.white,
              border: Border.all(color: ColorManager.primary, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(
                  category.catName,
                  style: getMediumStyle(
                    fontSize: FontSize.s16,
                  ),
                ),
                const SizedBox(width: AppSize.s8),
                Image.network(
                  category.image,
                  width: 35,
                  height: 35,
                  color: context.isDarkMode
                      ? ColorManager.grey
                      : ColorManager.grey1,
                  matchTextDirection: true,
                  // placeholderBuilder: (context) =>
                  //     const CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
