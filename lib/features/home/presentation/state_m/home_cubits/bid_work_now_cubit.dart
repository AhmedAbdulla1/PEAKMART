import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/entities/prodcut_entity.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/home/domain/entity/bid_work_now_entity.dart';
import 'package:Bid_Mart/features/home/domain/home_repo.dart';
import 'package:Bid_Mart/features/home/presentation/state_m/home_cubits/states.dart';

class BidWorkNowCubit extends Cubit<BidsState> {
  HomeRepository homeRepository = instance<HomeRepository>();
  List<ProductEntity> bidWorkNowData = [];

  BidWorkNowCubit() : super(BidsInitialState());

  Future<void> getBidWorkNow() async {
    emit(BidsLoadingState());

    Result<AppErrors, BidWorkNowEntity> result =
        await homeRepository.getBidWorkNow();

    result.pick(onData: (data) {
      bidWorkNowData = data.data;
      emit(BidWorkNowSuccessState(bidWorkNowData: bidWorkNowData));
    }, onError: (error) {
      emit(BidsFailureState(errors: error, onRetry: getBidWorkNow));
    });
  }
}
