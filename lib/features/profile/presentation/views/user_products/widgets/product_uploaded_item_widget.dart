import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/products/presentation/views/product_details/product_details_view.dart';
import 'package:peakmart/features/products/presentation/views/product_details/widgets/product_details_view_body.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/widgets/product_images_slider.dart';

class ProductsUploadedItemWidget extends StatelessWidget {
  const ProductsUploadedItemWidget({
    super.key,
    required this.product,
    required this.index,
    this.isUsingWithRandomProducts,
  });

  final int index;
  final ProductEntity product;
  final bool? isUsingWithRandomProducts;

  @override
  Widget build(BuildContext context) {
    String getEndDate() {
      DateTime startDate = DateTime.parse(product.startDate!);

      DateTime endDate = startDate.add(Duration(days: product.periodOfBid!));

      String endDateString = "${endDate.year.toString().padLeft(4, '0')}-"
          "${endDate.month.toString().padLeft(2, '0')}-"
          "${endDate.day.toString().padLeft(2, '0')}";
      return endDateString;
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: product.id);
      },
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: ColorManager.primary, width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.r),
                topRight: Radius.circular(18.r),
              ),
              child: product.imageUrl.isNotEmpty
                  ? ProductImagesSlider(imageUrls: product.imageUrl)
                  : Image.asset(
                      'assets/images/card.png',
                      width: double.infinity,
                      height: 120.h,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: getBoldStyle(
                        fontSize: FontSize.s16, color: ColorManager.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.description,
                    style: getMediumStyle(
                        fontSize: FontSize.s12, color: ColorManager.grey1),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  6.vGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomRichText(
                          title: "End Date: ", description: getEndDate()),
                      CustomRichText(
                          title: "Price Now: \$",
                          description: product.price.toString()),
                    ],
                  ),
                  10.vGap,
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40.h,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'End',
                              style: getBoldStyle(
                                fontSize: FontSize.s16,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      8.hGap,
                      Expanded(
                        child: SizedBox(
                          height: 40.h,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Cancel',
                              style: getBoldStyle(
                                fontSize: FontSize.s16,
                                color: ColorManager.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  10.vGap,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
