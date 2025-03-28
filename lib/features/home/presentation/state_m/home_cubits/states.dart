import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';

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
