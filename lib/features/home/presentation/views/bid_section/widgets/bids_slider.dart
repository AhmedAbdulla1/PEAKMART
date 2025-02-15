import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/home/domain/entity/bid_work_now_entity.dart';
import 'package:peakmart/features/home/domain/entity/ended_bids_entity.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/widgets/bid_item_stack.dart';

class BidsSlider extends StatefulWidget {
  const BidsSlider({
    super.key,
    required this.bidsWorkNow,
    this.isEnded = false,
    required this.endedBids,
  });

  final List<BidWorkNowData> bidsWorkNow;
  final List<EndedBidsData> endedBids;
  final bool isEnded;

  @override
  State<BidsSlider> createState() => _BidsSliderState();
}

class _BidsSliderState extends State<BidsSlider> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final bool isEmpty =
        widget.isEnded ? widget.endedBids.isEmpty : widget.bidsWorkNow.isEmpty;

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
      itemCount: isEmpty
          ? 1
          : (widget.isEnded
              ? widget.endedBids.length
              : widget.bidsWorkNow.length),
      itemBuilder: (BuildContext context, int index, int pageViewIndex) {
        if (isEmpty) {
          return const Center(child: WaitingWidget());
        }

        final isCurrent = index == _currentPage;

        return BidItemStack(
          isEnded: widget.isEnded,
          isCurrent: isCurrent,
          bidWorkNowItem: widget.isEnded ? null : widget.bidsWorkNow[index],
          endedBidItem: widget.isEnded ? widget.endedBids[index] : null,
        );
      },
    );
  }
}
