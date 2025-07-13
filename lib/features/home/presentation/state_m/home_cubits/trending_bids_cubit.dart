import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/entities/prodcut_entity.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/home/domain/entity/trending_bids_entity.dart';
import 'package:Bid_Mart/features/home/domain/home_repo.dart';
import 'package:Bid_Mart/features/home/presentation/state_m/home_cubits/states.dart';

class TrendingBidsCubit extends Cubit<BidsState> {
  HomeRepository homeRepository = instance<HomeRepository>();
  List<ProductEntity> trendingBidsData = [];

  TrendingBidsCubit() : super(BidsInitialState());

  Future<void> getTrendingBids() async {
    emit(BidsLoadingState());

    Result<AppErrors, TrendingBidsEntity> result =
        await homeRepository.getTrendingBids();

    result.pick(onData: (data) {
      trendingBidsData = data.data;
      debugPrint("🔥 Trending Bids from API: $trendingBidsData");
      debugPrint("🔥 Trending Bids from API: ${trendingBidsData.length}");
      emit(TrendingBidsSuccessState(trendingBidsData: trendingBidsData));
    }, onError: (error) {
      debugPrint("❌ Error fetching trending bids: $error");

      emit(BidsFailureState(errors: error, onRetry: getTrendingBids));
    });
  }
}
