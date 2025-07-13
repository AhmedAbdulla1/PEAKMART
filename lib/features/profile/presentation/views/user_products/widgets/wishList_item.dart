import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Bid_Mart/core/entities/prodcut_entity.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/features/products/presentation/views/product_details/product_details_view.dart';
import 'package:Bid_Mart/features/products/presentation/views/product_details/widgets/product_details_view_body.dart';
import 'package:Bid_Mart/features/profile/presentation/views/user_products/widgets/product_images_slider.dart';

class WishlistItemWidget extends StatelessWidget {
  const WishlistItemWidget({
    super.key,
    required this.product,
    required this.index,
  });

  final int index;
  final ProductEntity product;

  String _getEndDate() {
    final startDate = DateTime.parse(product.startDate!);
    final endDate = startDate.add(Duration(days: product.periodOfBid!));
    return "${endDate.year.toString().padLeft(4, '0')}-"
        "${endDate.month.toString().padLeft(2, '0')}-"
        "${endDate.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: context.isDarkMode ? ColorManager.black : ColorManager.white,
      onTap: () => Navigator.pushNamed(
        context,
        ProductDetails.routeName,
        arguments: product.id,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: context.primaryColor, width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image or placeholder
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

              // Product details
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    Text(
                      product.name,
                      style: getBoldStyle(fontSize: FontSize.s16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Product description
                    Text(
                      product.description,
                      style: getMediumStyle(
                        fontSize: FontSize.s12,
                        color: context.isDarkMode
                            ? ColorManager.grey
                            : ColorManager.grey1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    6.vGap,

                    // End date and price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRichText(
                            title: "End Date: ", description: _getEndDate()),
                        CustomRichText(
                            title: "Price Now: \$",
                            description: product.price.toString()),
                      ],
                    ),
                    10.vGap,

                    //* Remove from fav
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
