import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/payment/domain/enum/enums.dart';
import 'package:peakmart/features/payment/presentation/views/payment_dialog.dart';
import 'package:peakmart/features/products/presentation/views/product_details/product_details_view.dart';
import 'package:peakmart/features/products/presentation/views/product_details/widgets/product_details_view_body.dart';
import 'package:peakmart/features/profile/domain/enitiy/product_enrolled_entity.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/widgets/product_images_slider.dart';

class ProductEnrolledItemWidget extends StatelessWidget {
  const ProductEnrolledItemWidget({
    super.key,
    required this.product,
    required this.index,
    this.isUsingWithRandomProducts,
  });

  final int index;
  final ProductsEnrolledEntity product;
  final bool? isUsingWithRandomProducts;

  @override
  Widget build(BuildContext context) {
    final bool showCompleteButton = product.winnerStatus &&
        product.endDate == DateTime.now().toIso8601String().split('T').first;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: product.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
                    product.winnerStatus
                        ? Align(
                            alignment: Alignment.center,
                            child: Text(
                              "*You are the winner*",
                              style: getBoldStyle(
                                  fontSize: FontSize.s22,
                                  color: ColorManager.green),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        : const SizedBox(),
                    6.vGap,
                    Text(
                      product.itemName,
                      style: getBoldStyle(fontSize: FontSize.s16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    6.vGap,
                    CustomRichText(
                        title: "Your Bid: \$",
                        description: product.userBid.toString()),
                    6.vGap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRichText(
                            title: "End Date: ", description: product.endDate),
                        CustomRichText(
                          title: "Highest Bid: \$",
                          description: product.highestBid.toString(),
                        ),
                      ],
                    ),
                    10.vGap,

                    Visibility(
                      visible: !showCompleteButton,
                      child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return PaymentDialog(
                                      netPrice: product.highestBid.toDouble(),
                                      paymentProcess: PaymentProcess.BID,
                                    );
                                  });
                            },
                            child: const Text("Complete your bid")),
                      ),
                    )

                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: SizedBox(
                    //         height: 40.h,
                    //         child: ElevatedButton(
                    //           onPressed: () {},
                    //           child: Text(
                    //             'End',
                    //             style: getBoldStyle(
                    //               fontSize: FontSize.s16,
                    //               color: ColorManager.white,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     8.hGap,
                    //     Expanded(
                    //       child: SizedBox(
                    //         height: 40.h,
                    //         child: OutlinedButton(
                    //           onPressed: () {},
                    //           child: Text(
                    //             'Cancel',
                    //             style: getBoldStyle(
                    //               fontSize: FontSize.s16,
                    //               color: ColorManager.primary,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // 10.vGap,
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
