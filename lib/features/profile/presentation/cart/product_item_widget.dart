
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/products/data/models/product_model.dart';
import 'package:peakmart/features/products/presentation/views/product_details/product_details.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.product, required this.index});

  final int index;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // splashColor: ColorManager.white,
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: product);
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Text(
              "${index.toString()}.",
              style: getBoldStyle(
                fontSize: FontSize.s20,
                color: ColorManager.primary,
              ),
            ),
            10.hGap,
            product.imageUrl.isNotEmpty?
            Image.network(product.imageUrl[0], width: 50, height: 50)
            :Image.asset('assets/images/card.png', width: 50, height: 50),
            10.hGap,
            SizedBox(
              width: 250.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: getBoldStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.black,
                    ),
                    maxLines: 1,
                    // softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Auction End Date: ${product.endDate}',
                    maxLines: 1,
                  ),
                  Text('*${product.peopleRolledIn} people rolled in'),
                  Visibility(
                    visible: !product.isEnded,
                    child: Text('\$${product.price}',
                        style: getBoldStyle(
                            fontSize: FontSize.s16,
                            color: ColorManager.primary)),
                  ),
                  product.isEnded
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Text('\$${product.price}',
                                  style: getBoldStyle(
                                      fontSize: FontSize.s16,
                                      color: ColorManager.primary)),
                              Text('Ended',
                                  style: getBoldStyle(
                                      fontSize: FontSize.s16,
                                      color: ColorManager.primary)),
                            ])
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              SizedBox(
                                height: 35.h,
                                width: 100.w,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'End',
                                    style: getBoldStyle(
                                        fontSize: FontSize.s14,
                                        color: ColorManager.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35.h,
                                width: 100.w,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Cancel',
                                    style: getBoldStyle(
                                        fontSize: FontSize.s14,
                                        color: ColorManager.primary),
                                  ),
                                ),
                              ),
                            ]),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}