import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/home/presentation/views/apply_section/apply_view.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/titled_bid_section.dart';
import 'package:peakmart/features/home/presentation/views/category_section/catrgory_view.dart';
import 'package:peakmart/features/home/presentation/views/landing_section/landing_view.dart';
import 'package:peakmart/features/home/presentation/views/offers_section/offers_view.dart';
import 'package:peakmart/features/home/presentation/views/partners_section/partners_view.dart';
import 'package:peakmart/features/home/presentation/views/services_section/services_section.dart';

import '../state_m/home_cubits/bid_work_now_cubit.dart';
import '../state_m/home_cubits/ended_bids_cubit.dart';
import '../state_m/home_cubits/future_bids_cubit.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
    required this.onCategorySelected,
  });
  final Function(int categoryId) onCategorySelected;
  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: AppSize.s40),
          const LandingView(),
          const ServicesSection(),
          14.vGap,
          const TitledBidSection<FutureBidsCubit>(
            title: AppStrings.trendingBids,
            isTrending: true,
          ),
          20.vGap,
          const TitledBidSection<FutureBidsCubit>(
            title: AppStrings.futureBids,
            isFuture: true,
          ),
          18.vGap,
          OffersView(),
          CategorySection(
            onCategorySelected: widget.onCategorySelected,
          ),
          20.vGap,
          const TitledBidSection<BidWorkNowCubit>(
            title: AppStrings.bidsWorkNow,
          ),
          20.vGap,
          const TitledBidSection<EndedBidsCubit>(
            title: AppStrings.endedBids,
            isEnded: true,
          ),
          14.vGap,
          ApplyView(),
          14.vGap,
          PartnersView(),
          14.vGap,
        ],
      ),
    );
  }
}
