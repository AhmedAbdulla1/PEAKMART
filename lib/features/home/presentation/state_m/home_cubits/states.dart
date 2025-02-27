import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/features/home/domain/entity/bid_work_now_entity.dart';
import 'package:peakmart/features/home/domain/entity/ended_bids_entity.dart';
import 'package:peakmart/features/home/domain/entity/future_bids_entity.dart';
import 'package:peakmart/features/home/domain/entity/trending_bids_entity.dart';

sealed class BidsState {}

final class BidsInitialState extends BidsState {}

final class BidsLoadingState extends BidsState {}

final class BidsFailureState extends BidsState {
  final AppErrors errors;
  final Function() onRetry;
  BidsFailureState({required this.errors, required this.onRetry});
}

final class BidWorkNowSuccessState extends BidsState {
  final List<ProductEntity> bidWorkNowData;
  BidWorkNowSuccessState({required this.bidWorkNowData});
}

final class FutureBidsSuccessState extends BidsState {
  final List<ProductEntity> futureBidsData;
  FutureBidsSuccessState({required this.futureBidsData});
}

final class EndedBidsSuccessState extends BidsState {
  final List<ProductEntity> endedBidsData;
  EndedBidsSuccessState({required this.endedBidsData});
}

final class TrendingBidsSuccessState extends BidsState {
  final List<ProductEntity> trendingBidsData;
  TrendingBidsSuccessState({required this.trendingBidsData});
}
