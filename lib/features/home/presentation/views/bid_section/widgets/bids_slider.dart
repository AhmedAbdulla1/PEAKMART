import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/home/domain/entity/bid_work_now_entity.dart';
import 'package:peakmart/features/home/domain/entity/ended_bids_entity.dart';
import 'package:peakmart/features/home/domain/entity/future_bids_entity.dart'; // Import FutureBidsEntity
import 'package:peakmart/features/home/presentation/views/bid_section/widgets/bid_item_stack.dart';

class BidsSlider extends StatefulWidget {
  const BidsSlider({
    super.key,
    required this.bidsWorkNow,
    required this.endedBids,
    required this.futureBids,
    this.isEnded = false, required this.isFuture,
  });

  final List<BidWorkNowData> bidsWorkNow;
  final List<EndedBidsData> endedBids;
  final List<FutureBidsData> futureBids;
  final bool isEnded,isFuture;

  @override
  State<BidsSlider> createState() => _BidsSliderState();
}

class _BidsSliderState extends State<BidsSlider> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // final bool isEmpty =
    //     widget.isEnded ? widget.endedBids.isEmpty : widget.bidsWorkNow.isEmpty;

    final allBids = widget.isEnded
        ? widget.endedBids
        : widget.bidsWorkNow.isNotEmpty
            ? widget.bidsWorkNow
            : widget.futureBids;

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
        autoPlayAnimationDuration: const Duration(milliseconds: 80000),
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
      itemCount:
          allBids.isEmpty ? 1 : allBids.length, // Checking for non-empty data
      itemBuilder: (BuildContext context, int index, int pageViewIndex) {
        if (allBids.isEmpty) {
          return const Center(child: WaitingWidget());
        }

        final isCurrent = index == _currentPage;

        return BidItemStack(
          isEnded: widget.isEnded,
          isFuture: widget.isFuture,
          isCurrent: isCurrent,
          bidWorkNowItem:( widget.isEnded || widget.isFuture)
              ? null
              :  widget.bidsWorkNow[index],
          futureBidItem:
              widget.isFuture ? widget.futureBids[index] : null,
          endedBidItem: widget.isEnded ? widget.endedBids[index] : null,
        );
      },
    );
  }
}
