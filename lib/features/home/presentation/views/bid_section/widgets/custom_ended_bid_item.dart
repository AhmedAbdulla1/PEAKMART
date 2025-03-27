import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';

import '../../../../../../core/resources/values_manager.dart';

class CustomEndedBidItem extends StatelessWidget {
  const CustomEndedBidItem({
    super.key,
    required this.endedBidItem,
  });

  final ProductEntity endedBidItem;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: ColorManager.primary,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                child: Stack(children: [
                  endedBidItem.imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: endedBidItem.imageUrl[0],
                          width: double.infinity,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => const WaitingWidget(),
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
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: ColorManager.black.withOpacity(.5),
                  ),
                  Positioned(
                    top: 15.h,
                    child: SvgPicture.asset(ImageAssets.endedBadge),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p8, right: AppPadding.p19),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      endedBidItem.name,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getSemiBoldStyle(fontSize: FontSize.s16),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s4,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStrings.soldOut,
                      style: getMediumStyle(
                              color: ColorManager.red, fontSize: FontSize.s12)
                          .copyWith(fontFamily: FontConstants.fontCabinFamily),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s4,
                  ),
                  RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppStrings.soldFor,
                        style: getMediumStyle(fontSize: FontSize.s14).copyWith(
                            fontFamily: FontConstants.fontCabinFamily),
                      ),
                      TextSpan(
                        text: "\$${endedBidItem.price}",
                        style: getBoldStyle(fontSize: FontSize.s22).copyWith(
                            fontFamily: FontConstants.fontCabinFamily),
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
