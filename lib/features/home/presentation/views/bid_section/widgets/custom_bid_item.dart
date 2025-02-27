import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/products/presentation/views/product_details/product_details.dart';

import '../../../../../../core/resources/values_manager.dart';

class CustomBidItem extends StatelessWidget {
  const CustomBidItem({
    super.key,
    required this.bidItem,
  });

  final ProductEntity bidItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ProductDetails.routeName,arguments: bidItem);
      },
      child: Center(
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: ColorManager.primary,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                    ),
                  ),
                  child: bidItem.imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: bidItem.imageUrl[0],
                          width: double.infinity,
                          fit: BoxFit.fill,
                          placeholder: (context, url) {
                            return const WaitingWidget();
                          },
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            size: 28,
                            color: ColorManager.red,
                          ),
                        )
                      : Image.asset(
                          "assets/images/card.png",
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p8, right: AppPadding.p19),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        bidItem.name,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: getSemiBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s16),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        bidItem.description,
                        style: getMediumStyle(
                                color: ColorManager.grey1, fontSize: FontSize.s12)
                            .copyWith(fontFamily: FontConstants.fontCabinFamily),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppStrings.nowBid}\n${"\$${bidItem.price}"}",
                          style: getSemiBoldStyle(
                              fontSize: FontSize.s12, color: ColorManager.black),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(AppStrings.enrollNow),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
