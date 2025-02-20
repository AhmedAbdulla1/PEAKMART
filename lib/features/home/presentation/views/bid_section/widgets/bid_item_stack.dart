import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/features/home/domain/entity/bid_work_now_entity.dart';
import 'package:peakmart/features/home/domain/entity/future_bids_entity.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/widgets/custom_bid_item.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/widgets/custom_ended_bid_item.dart';

import '../../../../domain/entity/ended_bids_entity.dart';

class BidItemStack extends StatelessWidget {
  const BidItemStack({
    super.key,
    required this.isEnded,
    required this.isFuture,
    required this.isCurrent,
    required this.isTrending,
    this.bidWorkNowItem,
    this.endedBidItem,
    this.futureBidItem,
    this.trendingItem,
  });

  final bool isEnded, isFuture, isCurrent, isTrending;

  final BidWorkNowData? bidWorkNowItem;
  final EndedBidsData? endedBidItem;
  final FutureBidsData? futureBidItem;
  final FutureBidsData? trendingItem;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isEnded
            ? CustomEndedBidItem(endedBidItem: endedBidItem!)
            : isFuture
                ? CustomBidItem(bidItem: futureBidItem)
                : isTrending
                    ? CustomBidItem(
                        bidItem: trendingItem,
                      )
                    : CustomBidItem(
                        bidItem: bidWorkNowItem,
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
