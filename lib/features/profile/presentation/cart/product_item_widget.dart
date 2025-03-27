import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/products/presentation/views/product_details/product_details.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
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
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: product);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
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
                  ? CachedNetworkImage(
                      imageUrl: product.imageUrl[0],
                      width: double.infinity,
                      height: 150.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const WaitingWidget(),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        size: 28,
                        color: ColorManager.red,
                      ),
                    )
                  : Image.asset(
                      'assets/images/card.png',
                      width: double.infinity,
                      height: 150.h,
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
                        fontSize: FontSize.s18, color: ColorManager.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.description,
                    style: getMediumStyle(
                        fontSize: FontSize.s14, color: ColorManager.grey1),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  6.vGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "${AppStrings.auctionEnd}: ",
                              style: getRegularStyle(
                                  fontSize: AppSize.s12,
                                  color: ColorManager.darkGrey),
                            ),
                            TextSpan(
                              text: product.endDate,
                              style: getBoldStyle(
                                  fontSize: AppSize.s12,
                                  color: ColorManager.primary),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${AppStrings.priceNow}: ",
                            style: getRegularStyle(
                                fontSize: AppSize.s12,
                                color: ColorManager.darkGrey),
                          ),
                          Text(
                            "\$${product.price}",
                            style: getBoldStyle(
                                fontSize: AppSize.s12,
                                color: ColorManager.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                  10.vGap,
                  isUsingWithRandomProducts == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (!product.isEnded)
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("Enroll Now"),
                                ),
                              )
                            else
                              Text(
                                "Ended",
                                style: getBoldStyle(
                                    fontSize: 14.sp, color: Colors.red),
                              ),
                          ],
                        )
                      : Row(
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
