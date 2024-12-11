import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peakmart/app/resources/color_manager.dart';
import 'package:peakmart/app/resources/font_manager.dart';
import 'package:peakmart/app/resources/style_manager.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/ended_bids_card_model.dart';

import '../../../../../../app/resources/values_manager.dart';

class CustomEndedBidsItem extends StatelessWidget {
  const CustomEndedBidsItem({super.key, required this.endedBidsCardModel});

  final EndedBidsCardModel endedBidsCardModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: ColorManager.primary,
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Stack(
                    children:[ Image.asset(
                      endedBidsCardModel.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    Positioned(
                      top: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/like.svg',
                        color: ColorManager.white,
                      ),
                    )
                    ]),
                ),
              ),
              // CachedNetworkImage(
              //   imageUrl:
              //       "https://th.bing.com/th/id/R.f8cd97dceece7f86782b9f3ea85b69f9?rik=S0gyWHLbi4myzA&pid=ImgRaw&r=0",
              //   placeholder: (context, url) => const CircularProgressIndicator(),
              //   errorWidget: (context, url, error) => const Icon(Icons.error),
              // ),
              const SizedBox(
                height: AppSize.s10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  endedBidsCardModel.title,
                  maxLines: 2,
                  // overflow: TextOverflow.ellipsis,
                  style: getMediumStyle(
                      color: ColorManager.black, fontSize: FontSize.s16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                child: Text(
                  'Sold out',
                  style: getMediumStyle(
                      color: ColorManager.red, fontSize: FontSize.s12),
                ),
              ),
              // const SizedBox(
              //   height: 5,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8,vertical: 5),
                child: RichText(
                  text: TextSpan(
                    text: 'Sold for: ',
                    style: getSemiBoldStyle(
                        fontSize: FontSize.s12, color: ColorManager.black),
                    children: [
                      TextSpan(
                        text:endedBidsCardModel.price,
                          style: getBoldStyle(
                              fontSize: FontSize.s22, color: ColorManager.black))
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
