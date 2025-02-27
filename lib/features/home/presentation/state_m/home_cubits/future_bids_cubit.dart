import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/home/domain/home_repo.dart';
import 'package:peakmart/features/home/presentation/state_m/home_cubits/states.dart';

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
