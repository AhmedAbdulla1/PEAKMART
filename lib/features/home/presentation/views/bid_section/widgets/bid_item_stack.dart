import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/features/home/domain/entity/bid_work_now_entity.dart';
import 'package:peakmart/features/home/domain/entity/ended_bids_entity.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/widgets/custom_bid_item.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/widgets/custom_ended_bid_item.dart';

class BidItemStack extends StatelessWidget {
  const BidItemStack({
    super.key,
    required this.isEnded,
    required this.isCurrent,
    this.bidWorkNowItem,
    this.endedBidItem,
  });

  final bool isEnded;
  final bool isCurrent;
  final BidWorkNowData? bidWorkNowItem;
  final EndedBidsData? endedBidItem;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isEnded
            ? CustomEndedBidItem(endedBidItem: endedBidItem!)
            : CustomBidItem(bidWorkNowItem: bidWorkNowItem!),
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
