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
    this.isEnded = false,  this.isFuture= false,
  });

  final String title;
  final bool isEnded,isFuture;
  static List<BidWorkNowData> loadedBidWorkNow = [];
  static List<EndedBidsData> loadedEndedBids = [];
  static List<FutureBidsData> loadedFutureBids = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, BidsState>(
      builder: (context, state) {
        if (state is BidWorkNowSuccessState) {
          loadedBidWorkNow = state.bidWorkNowData;
          print("loadedBidWorkNow ${loadedBidWorkNow.length}");
        }
        if (state is EndedBidsSuccessState) {
          loadedEndedBids = state.endedBidsData;
          print("loadedEndedBids ${loadedEndedBids.length}");
        }
        if (state is FutureBidsSuccessState) {
          loadedFutureBids = state.futureBidsData;
          print("loadedFutureBids ${loadedFutureBids.length}");
        }

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
                bidsWorkNow: loadedBidWorkNow,
                endedBids: loadedEndedBids,
                isEnded: isEnded,
                futureBids: loadedFutureBids,
              ),
            ),
          ],
        );
      },
    );
  }
}
