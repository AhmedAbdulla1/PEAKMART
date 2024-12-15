import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/bid_card_model.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/transforming_bid_item.dart';

class BidPageView extends StatefulWidget {
  const BidPageView({super.key, required this.bidCards, this.isEnded = false});

  final List<BidCardModel> bidCards;
  final bool isEnded;

  @override
  _BidPageViewState createState() => _BidPageViewState();
}

class _BidPageViewState extends State<BidPageView> {
  final LoopPageController _pageController =
      LoopPageController(initialPage: 1, viewportFraction: 0.66);
  double page = 1;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(
      () => setState(() {
        page = _pageController.page;
      }),
    );
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      _pageController.animateToPage(
        page.toInt()+1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear
      );
    });
  }

  double _calculateScale(int index) {
    // Normalize the index to the looping range based on the current page
    double currentPage = page; // Fallback to `page` if null
    int itemCount = widget.bidCards.length;

    // Calculate the normalized difference considering the looping
    double normalizedIndex = (index - currentPage) % itemCount;
    if (normalizedIndex < -0.5) normalizedIndex += itemCount; // Correct for negative wrapping
    if (normalizedIndex > 0.5) normalizedIndex -= itemCount; // Correct for positive wrapping

    // Calculate scale based on normalizedIndex
    double scale = normalizedIndex.abs().clamp(0.0, 1.0).toDouble();
    return 1 - (scale * 0.2); // Gradual scale decrease
  }



  // Function to calculate the opacity based on the scale
  double _calculateOpacity(int index) {
    // Calculate the distance from the current page
    double distance = (page - index).abs();

    // Use a smooth fade effect where opacity decreases with distance
    return  (distance.clamp(0.0, 1.0) * 0.5);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        _pauseAutoScroll();
      },
      onPointerUp: (_) {
        // Resume the timer after a delay when user stops interacting
        _resumeAutoScroll();
      },
      child: LoopPageView.builder(
        controller: _pageController,
        itemCount: widget.bidCards.length,
        itemBuilder: (context, index) {
          double scale = _calculateScale(index);
          double opacity = _calculateOpacity(index);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TransformingBidItem(
              scale: scale,
              opacity: opacity,
              bidCardModel: widget.bidCards[index],
              isEnded: widget.isEnded,
            ),
          );
        },
      ),
    );
  }


  void _pauseAutoScroll() {
    _timer?.cancel(); // Cancel the current timer
    _timer = null;
  }

  void _resumeAutoScroll() {
    // Start the timer after a short delay to avoid immediate scrolling
    Future.delayed(const Duration(seconds: 2), () {
      if (_timer == null) {
        _startAutoScroll();
      }
    });
  }

}
