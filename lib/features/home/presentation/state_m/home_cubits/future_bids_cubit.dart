import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/entities/prodcut_entity.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/home/domain/home_repo.dart';
import 'package:Bid_Mart/features/home/presentation/state_m/home_cubits/states.dart';

import '../../../domain/entity/future_bids_entity.dart';

class FutureBidsCubit extends Cubit<BidsState> {
  HomeRepository homeRepository = instance<HomeRepository>();
  List<ProductEntity> futureBidsData = [];

  FutureBidsCubit() : super(BidsInitialState());

  Future<void> getFutureBids() async {
    emit(BidsLoadingState());

    Result<AppErrors, FutureBidsEntity> result =
        await homeRepository.getFutureBids();

    result.pick(onData: (data) {
      futureBidsData = data.data;
      emit(FutureBidsSuccessState(futureBidsData: futureBidsData));
    }, onError: (error) {
      emit(BidsFailureState(errors: error, onRetry: getFutureBids));
    });
  }
}
