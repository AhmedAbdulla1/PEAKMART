import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/home/presentation/views/services_section/item_service_model.dart';

class ItemService extends StatelessWidget {
  const ItemService({super.key, required this.itemServiceModel});
  final ItemServiceModel itemServiceModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 251,
      height: 170,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Card(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(20), // زوايا دائرية
          // ),
          elevation: 10, // تأثير ظل خفيف
          child: Padding(
            padding: const EdgeInsets.all(12.0), // مسافات داخل الكارد
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
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                          height: 4),
                      Text(
                        itemServiceModel.description,
                        style: getMediumStyle(
                          fontSize: FontSize.s10,
                          color: Colors.black,
                        ),
                        maxLines:4,
                        overflow:
                            TextOverflow.ellipsis, // تقصير النص إذا كان طويلاً
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8), // مسافة بين النص والصورة
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    itemServiceModel.image,
                    height: 200, // ضبط أبعاد الصورة
                    fit: BoxFit.contain, // لتناسب الصورة داخل الإطار
                    alignment: Alignment.center, // محاذاة الصورة إلى الأعلى
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
