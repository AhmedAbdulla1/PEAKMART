import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/features/home/presentation/views/services_section/item_service_model.dart';

class ItemService extends StatelessWidget {
  const ItemService({super.key, required this.itemServiceModel});
  final ItemServiceModel itemServiceModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      height: 170,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Card(
          shadowColor: context.isDarkMode ? Colors.black : Colors.white,
          // color: context.isDarkMode ? Colors.white : Colors.white,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        itemServiceModel.title,
                        style: getSemiBoldStyle(
                          fontSize: FontSize.s16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        itemServiceModel.description,
                        style: getMediumStyle(
                          fontSize: FontSize.s10,
                        ),
                        maxLines: 4,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    itemServiceModel.image,
                    height: 200,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
