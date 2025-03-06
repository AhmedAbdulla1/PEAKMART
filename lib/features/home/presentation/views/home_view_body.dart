import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/features/home/presentation/state_m/home_cubits/states.dart';
import 'package:peakmart/features/home/presentation/state_m/home_cubits/trending_bids_cubit.dart';
import 'package:peakmart/features/home/presentation/views/apply_section/apply_view.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/titled_bid_section.dart';
import 'package:peakmart/features/home/presentation/views/category_section/catrgory_view.dart';
import 'package:peakmart/features/home/presentation/views/landing_section/landing_view.dart';
import 'package:peakmart/features/home/presentation/views/offers_section/offers_view.dart';
import 'package:peakmart/features/home/presentation/views/partners_section/partners_view.dart';
import 'package:peakmart/features/home/presentation/views/services_section/services_section.dart';
import 'package:peakmart/features/products/presentation/views/random_products/random_products_view.dart';

import '../state_m/home_cubits/bid_work_now_cubit.dart';
import '../state_m/home_cubits/ended_bids_cubit.dart';
import '../state_m/home_cubits/future_bids_cubit.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: AppSize.s40),
          const LandingView(),
          const ServicesSection(),
          const SizedBox(height: AppSize.s12),
          const TitledBidSection<FutureBidsCubit>(
            title: AppStrings.trendingBids,
            isTrending: true,
          ),
          const SizedBox(height: AppSize.s12),
          const TitledBidSection<FutureBidsCubit>(
            title: AppStrings.futureBids,
            isFuture: true,
          ),
          const SizedBox(height: AppSize.s12),
          OfferSView(),
          CategorySection(),
          const SizedBox(height: AppSize.s12),
          const TitledBidSection<BidWorkNowCubit>(
            title: AppStrings.bidsWorkNow,
          ),
          const SizedBox(height: AppSize.s12),
          const TitledBidSection<EndedBidsCubit>(
            title: AppStrings.endedBids,
            isEnded: true,
          ),
          const SizedBox(height: AppSize.s12),
          ApplyView(),
          const SizedBox(height: AppSize.s12),
          PartnersView(),
          const SizedBox(height: AppSize.s12),
          CustomElevatedButtonWithoutStream(
            onPressed: () {
              final bidWorkNowState =
                  BlocProvider.of<BidWorkNowCubit>(context).state;
              final futureBidsState =
                  BlocProvider.of<FutureBidsCubit>(context).state;
              final trendingBidsState =
                  BlocProvider.of<TrendingBidsCubit>(context).state;

              List<ProductEntity> futureProducts =
                  _getProductsFromState(futureBidsState);
              List<ProductEntity> trendingProducts =
                  _getProductsFromState(trendingBidsState);
              List<ProductEntity> currentProducts =
                  _getProductsFromState(bidWorkNowState);
              List<ProductEntity> allProducts = [
                ...futureProducts,
                ...trendingProducts,
                ...currentProducts
              ];
              Navigator.pushNamed(context, RandomProductsView.routeName,
                  arguments: allProducts);
            },
            text: "Nav to Bid owner",
          ),
        ],
      ),
    );
  }

  List<ProductEntity> _getProductsFromState(BidsState state) {
    if (state is BidWorkNowSuccessState) {
      return state.bidWorkNowData;
    } else if (state is FutureBidsSuccessState) {
      return state.futureBidsData;
    } else if (state is TrendingBidsSuccessState) {
      return state.trendingBidsData;
    }
    return [];
  }
}
