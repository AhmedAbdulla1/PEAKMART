import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/home/presentation/state_m/bid_work_now_cubit/bid_work_now_cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/ended_bids_cubit/ended_bids_cubit.dart';
import 'package:peakmart/features/home/presentation/views/apply_section/apply_view.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/titled_bid_section.dart';
import 'package:peakmart/features/home/presentation/views/landing_section/landing_view.dart';
import 'package:peakmart/features/home/presentation/views/partners_section/partners_view.dart';
import 'package:peakmart/features/home/presentation/views/services_section/services_section.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: AppSize.s40),
        const LandingView(),
        const ServicesSection(),
        const SizedBox(height: AppSize.s12),
        BlocProvider(
          create: (context) => BidWorkNowCubit()..getBidWorkNow(),
          child: const TitledBidSection<BidWorkNowCubit>(
            title: AppStrings.bidsWorkNow,
          ),
        ),

        const SizedBox(height: AppSize.s12),
        BlocProvider(
          create: (context) => EndedBidsCubit()..getEndedBids(),
          child: const TitledBidSection<EndedBidsCubit>(
            title: AppStrings.endedBids,
            isEnded: true,
          ),
        ),

        // const SizedBox(height: AppSize.s12),

        // BlocProvider(
        //   create: (context) => TrendingBidsCubit(),
        //   child: TitledBidSection(
        //     title: AppStrings.trendingBids,
        //     bids: bids,
        //     endedBids: [],
        //   ),
        // ),

        // const SizedBox(height: AppSize.s12),

        // BlocProvider(
        //   create: (context) => FutureBidsCubit(),
        //   child: TitledBidSection(
        //     title: AppStrings.futureBids,
        //     bids: bidWorkNow,
        //     endedBids: [],
        //   ),
        // ),

        const SizedBox(height: AppSize.s12),
        const ApplyView(),
        const SizedBox(height: AppSize.s12),
        const PartnersView(),
        const SizedBox(height: AppSize.s12),
      ],
    );
  }
}
