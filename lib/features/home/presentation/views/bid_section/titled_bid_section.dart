import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/home/domain/entity/bid_work_now_entity.dart';
import 'package:peakmart/features/home/domain/entity/ended_bids_entity.dart';
import 'package:peakmart/features/home/presentation/state_m/bid_work_now_cubit/bid_work_now_cubit.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/widgets/bids_slider.dart';

class TitledBidSection<C extends Cubit<BidsState>> extends StatelessWidget {
  const TitledBidSection({
    super.key,
    required this.title,
    this.isEnded = false,
  });

  final String title;
  final bool isEnded;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, BidsState>(
      builder: (context, state) {
        List<BidWorkNowData> loadedBidWorkNow = [];
        List<EndedBidsData> loadedEndedBids = [];
        if (state is BidsSuccessState) {
          if (isEnded) {
            loadedEndedBids = state.endedBidsData ?? [];
          } else {
            loadedBidWorkNow = state.bidWorkNowData ?? [];
          }
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
                bidsWorkNow: loadedBidWorkNow,
                endedBids: loadedEndedBids,
                isEnded: isEnded,
              ),
            ),
          ],
        );
      },
    );
  }
}
