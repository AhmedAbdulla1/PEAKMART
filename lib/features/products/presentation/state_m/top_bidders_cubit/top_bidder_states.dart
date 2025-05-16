import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/features/products/domain/entity/top_bidders_entity.dart';

sealed class TopBiddersState {}

final class TopBiddersInitialState extends TopBiddersState {}

final class TopBiddersLoadingState extends TopBiddersState {}

final class TopBiddersFailureState extends TopBiddersState {
  final AppErrors errors;
  final Function() onRetry;
  TopBiddersFailureState({required this.errors, required this.onRetry});
}

final class TopBiddersSuccessState extends TopBiddersState {
  final List<TopBiddersData> topBidders;
  TopBiddersSuccessState({required this.topBidders});
}
