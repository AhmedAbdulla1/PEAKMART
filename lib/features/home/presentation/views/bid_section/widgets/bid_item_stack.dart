import 'package:flutter/material.dart';
import 'package:Bid_Mart/core/entities/prodcut_entity.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/features/home/presentation/views/bid_section/widgets/custom_bid_item.dart';
import 'package:Bid_Mart/features/home/presentation/views/bid_section/widgets/custom_ended_bid_item.dart';

class BidItemStack extends StatelessWidget {
  const BidItemStack({
    super.key,
    required this.isEnded,
    required this.isFuture,
    required this.isCurrent,
    required this.isTrending,
    required this.productEntity,
  });

  final bool isEnded, isFuture, isCurrent, isTrending;

  final ProductEntity productEntity;
  // final EndedBidsData? endedBidItem;
  // final FutureBidsData? futureBidItem;
  // final FutureBidsData? trendingItem;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isEnded
            ? CustomEndedBidItem(endedBidItem: productEntity)
            : CustomBidItem(
                bidItem: productEntity,
              ),
        AnimatedOpacity(
          opacity: isCurrent ? 0.0 : 0.9,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          child: Container(
            width: double.infinity,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: ColorManager.black.withOpacity(0.3),
              borderRadius: const BorderRadius.all(
                Radius.circular(23),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
