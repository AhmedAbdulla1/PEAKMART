import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/bid_card_model.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/ended_bids_card_model.dart';

import '../../../../../../core/resources/values_manager.dart';

class CustomEndedBidItem extends StatelessWidget {
  const CustomEndedBidItem({
    super.key,
    required this.endedBidsCardModel,
  });
  final EndedBidsCardModel endedBidsCardModel;
  @override
  Widget build(BuildContext context) {
    return Center(
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
                  Image.asset(
                    endedBidsCardModel.image,
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
                  Text(
                    endedBidsCardModel.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s16),
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
                        style: getMediumStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s14)
                            .copyWith(
                                fontFamily: FontConstants.fontCabinFamily),
                      ),
                      TextSpan(
                        text: endedBidsCardModel.price,
                        style: getBoldStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s22)
                            .copyWith(
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
