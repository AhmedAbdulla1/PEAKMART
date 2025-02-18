
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/home/domain/entity/trending_bids_entity.dart';
import 'package:peakmart/features/home/domain/home_repo.dart';
import 'package:peakmart/features/home/presentation/state_m/home_cubits/states.dart';

class TrendingBidsCubit extends Cubit<BidsState> {
  HomeRepository homeRepository = instance<HomeRepository>();
  List<TrendingBidsData> trendingBidsData = [];

  TrendingBidsCubit() : super(BidsInitialState());

  Future<void> getTrendingBids() async {
    emit(BidsLoadingState());

    Result<AppErrors, TrendingBidsEntity> result =
        await homeRepository.getTrendingBids();

    result.pick(onData: (data) {
      trendingBidsData = data.data;
      emit(TrendingBidsSuccessState(trendingBidsData: trendingBidsData));
    }, onError: (error) {
      emit(BidsFailureState(errors: error, onRetry: getTrendingBids));
    });
  }
}
