part of 'bid_work_now_cubit/bid_work_now_cubit.dart';

sealed class BidsState {}

final class BidsInitialState extends BidsState {}

final class BidsLoadingState extends BidsState {}

final class BidsFailureState extends BidsState {
  final AppErrors errors;
  final Function() onRetry;
  BidsFailureState({required this.errors, required this.onRetry});
}

final class BidsSuccessState extends BidsState {
  final BidWorkNowEntity? bidWorkNowEntity;
  final FutureBidsEntity? futureBidsEntity;
  final EndedBidsEntity? endedBidsEntity;
  final List<BidWorkNowData>? bidWorkNowData;
  final List<FutureBidsData>? futureBidsData;
  final List<EndedBidsData>? endedBidsData;

  BidsSuccessState(
      {this.futureBidsEntity,
      this.futureBidsData,
      this.bidWorkNowData,
      this.endedBidsData,
      this.bidWorkNowEntity,
      this.endedBidsEntity});
}
