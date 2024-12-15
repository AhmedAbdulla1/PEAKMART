import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/bid_card_model.dart';

import '../../../../../../core/resources/values_manager.dart';

class CustomBidItem extends StatelessWidget {
  const CustomBidItem({super.key, required this.bidCardModel,});
  final BidCardModel bidCardModel;
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
                child: Image.asset(
                  bidCardModel.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // CachedNetworkImage(
            //   imageUrl:
            //       "https://th.bing.com/th/id/R.f8cd97dceece7f86782b9f3ea85b69f9?rik=S0gyWHLbi4myzA&pid=ImgRaw&r=0",
            //   placeholder: (context, url) => const CircularProgressIndicator(),
            //   errorWidget: (context, url, error) => const Icon(Icons.error),
            // ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p8, right: AppPadding.p19),
              child: Column(
                children: [
                  Text(
                    bidCardModel.title,
                    maxLines: 2,
                    style: getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s16),
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Text(
                    bidCardModel.subTitle,
                    style: getMediumStyle(
                        color: ColorManager.grey1, fontSize: FontSize.s12).copyWith(fontFamily: FontConstants.fontCabinFamily),
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bidCardModel.price,
                        style: getSemiBoldStyle(
                            fontSize: FontSize.s12, color: ColorManager.black),
                      ),
                       ElevatedButton(onPressed: () {}, child:const Text( 'Enroll Now')),
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
    );
  }
}
