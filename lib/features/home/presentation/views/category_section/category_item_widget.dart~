import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peakmart/app/resources/color_manager.dart';
import 'package:peakmart/app/resources/font_manager.dart';
import 'package:peakmart/app/resources/style_manager.dart';
import 'package:peakmart/app/resources/values_manager.dart';
import 'package:peakmart/features/home/domain/models/category_model.dart';

class CategoryItemWidget extends StatelessWidget {
  CategoryItemWidget(
      {super.key,
      required this.category,
      required this.onTap,
      this.isSelected = false});

  final CategoryModel category;
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
          constraints: const  BoxConstraints(
            maxHeight: 50,
          ),
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p5),

            decoration: BoxDecoration(
              color: isSelected ? ColorManager.lightPrimary : ColorManager.white,
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(
                  category.title,
                  style: getMediumStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.grey1,
                  ),
                ),
                const SizedBox(width: AppSize.s8),
                SvgPicture.network(
                  category.imageUrl,
                  width: 40,
                  height: 40,
                  color: ColorManager.grey1,
                  matchTextDirection: true,
                  placeholderBuilder: (context) =>
                      const CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
