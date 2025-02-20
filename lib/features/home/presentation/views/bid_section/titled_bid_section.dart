import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/home/domain/entity/bid_work_now_entity.dart';
import 'package:peakmart/features/home/domain/entity/ended_bids_entity.dart';
import 'package:peakmart/features/home/domain/entity/future_bids_entity.dart';
import 'package:peakmart/features/home/presentation/state_m/home_cubits/states.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/widgets/bids_slider.dart';

class TitledBidSection<C extends Cubit<BidsState>> extends StatelessWidget {
  const TitledBidSection({
    super.key,
    required this.title,
    this.isEnded = false,
    this.isFuture = false,
    this.isTrending = false,
  });

  final String title;
  final bool isEnded, isFuture, isTrending;
  static List<BidWorkNowData> loadedBidWorkNow = [];
  static List<EndedBidsData> loadedEndedBids = [];
  static List<FutureBidsData> loadedFutureBids = [];
  static List<FutureBidsData> loadedTrendingBids = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, BidsState>(
      builder: (context, state) {
        if (state is BidWorkNowSuccessState) {
          loadedBidWorkNow = state.bidWorkNowData;
        }
        if (state is EndedBidsSuccessState) {
          loadedEndedBids = state.endedBidsData;
          ;
        }
        if (state is FutureBidsSuccessState) {
          loadedFutureBids = state.futureBidsData;
          loadedTrendingBids = state.futureBidsData;
        }
        if (state is TrendingBidsSuccessState) {
          // loadedTrendingBids = state.trendingBidsData;

        }
        debugPrint(
            "📢 Passing Trending Bids to BidsSlider: ${loadedTrendingBids.length}");
        debugPrint(
            "📢 Passing Future Bids to BidsSlider: ${loadedFutureBids.length}");
        debugPrint(
            "📢 Passing Work Now Bids to BidsSlider: ${loadedBidWorkNow.length}");
        debugPrint(
            "📢 Passing Ended Bids to BidsSlider: ${loadedEndedBids.length}");

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: getBoldStyle(
                fontSize: FontSize.s28,
                color: ColorManager.primary,
              ),
            ),
            const SizedBox(height: AppSize.s12),
            SizedBox(
              height: 370.h,
              child: BidsSlider(
                isFuture: isFuture,
                isTrending: isTrending,
                isEnded: isEnded,
                bidsWorkNow: loadedBidWorkNow,
                endedBids: loadedEndedBids,
                trendingBids: loadedTrendingBids,
                futureBids: loadedFutureBids,
              ),
            ),
          ],
        );
      },
    );
  }
}
