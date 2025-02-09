import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/bid_card_model.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/ended_bids_card_model.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/widgets/custom_bid_item.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/widgets/custom_ended_bid_item.dart';

class BidsSlider extends StatefulWidget {
  const BidsSlider(
      {super.key,
      required this.bidCardModel,
      this.isEnded = false,
      required this.endedBidsCardModel});
  final List<BidCardModel> bidCardModel;
  final List<EndedBidsCardModel> endedBidsCardModel;
  final bool isEnded;

  @override
  State<BidsSlider> createState() => _BidsSliderState();
}

class _BidsSliderState extends State<BidsSlider> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: widget.isEnded ? 340.h : 370.h,
        aspectRatio: 16 / 9,
        viewportFraction: 0.65,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        onPageChanged: (index, reason) {
          setState(() {
            _currentPage = index;
          });
        },
        scrollDirection: Axis.horizontal,
      ),
      itemCount: widget.isEnded
          ? widget.endedBidsCardModel.length
          : widget.bidCardModel.length,
      itemBuilder: (BuildContext context, int index, int pageViewIndex) {
        final isCurrent = index == _currentPage;

        return Stack(
          children: [
            widget.isEnded
                ? CustomEndedBidItem(
                    endedBidsCardModel: widget.endedBidsCardModel[index],
                  )
                : CustomBidItem(
                    bidCardModel: widget.bidCardModel[index],
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
      },
    );
  }
}
