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
    this.isEnded = false,
    this.isFuture = false,
    this.isTrending = false,
    required this.trendingBids,
  });

  final List<BidWorkNowData> bidsWorkNow;
  final List<EndedBidsData> endedBids;
  final List<FutureBidsData> futureBids;
  final List<FutureBidsData> trendingBids;
  final bool isEnded, isFuture, isTrending;

  @override
  State<BidsSlider> createState() => _BidsSliderState();
}

class _BidsSliderState extends State<BidsSlider> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final allBids = widget.isEnded
        ? widget.endedBids
        : widget.bidsWorkNow.isNotEmpty
            ? widget.bidsWorkNow
            : widget.futureBids.isNotEmpty
                ? widget.futureBids
                : widget.trendingBids;
    // debugPrint(
    //     "BidsSlider received ${widget.trendingBids.length} trending bids");

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
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
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
          isTrending: widget.isTrending,
          isCurrent: isCurrent,
          bidWorkNowItem:
              (widget.isEnded || widget.isFuture || widget.isTrending)
                  ? null
                  : widget.bidsWorkNow[index],
          trendingItem: widget.isTrending ? widget.trendingBids[index] : null,
          futureBidItem: widget.isFuture ? widget.futureBids[index] : null,
          endedBidItem: widget.isEnded ? widget.endedBids[index] : null,
        );
      },
    );
  }
}
