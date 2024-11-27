import 'package:flutter/material.dart';
import 'package:peakmart/app/resources/values_manager.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/ended_bids_card_model.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/widgets/custom_bid_item.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/bid_card_model.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/widgets/custom_ended_bids_item.dart';

class TransformingBidItem extends StatelessWidget {
  const TransformingBidItem(
      {super.key,
      required this.scale,
      required this.opacity,
      required this.bidCardModel,
      this.isEnded = false});

  final double scale, opacity;
  final bool isEnded;
  final BidCardModel bidCardModel;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(opacity),
          BlendMode.srcATop,
        ),
        child: !isEnded
            ? CustomBidItem(
                bidCardModel: BidCardModel(
                image: bidCardModel.image,
                title: bidCardModel.title,
                subTitle: bidCardModel.subTitle,
                price: bidCardModel.price,
              ))
            : CustomEndedBidsItem(
                endedBidsCardModel: EndedBidsCardModel(
                    image: bidCardModel.image,
                    title: bidCardModel.title,
                    price: '\$30000'),
              ),
      ),
    );
  }
}
