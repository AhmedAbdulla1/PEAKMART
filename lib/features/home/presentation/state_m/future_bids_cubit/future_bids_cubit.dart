import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/home/domain/entity/future_bids_entity.dart';
import 'package:peakmart/features/home/domain/home_repo.dart';
import 'package:peakmart/features/home/presentation/state_m/bid_work_now_cubit/bid_work_now_cubit.dart';

class FutureBidsCubit extends Cubit<BidsState> {
  HomeRepository homeRepository = instance<HomeRepository>();
  List<FutureBidsData> futureBidsData = [];
  FutureBidsCubit() : super(BidsInitialState());
  Future<void> getFutureBids() async {
    emit(
      BidsLoadingState(),
    );

    Result<AppErrors, FutureBidsEntity> result =
        await homeRepository.getFutureBids();

    result.pick(onData: (data) {
      futureBidsData = data.data;
      debugPrint(
        'future bids data list in cubit is $futureBidsData',
      );
      // Navigator.pop(context);
      emit(
        BidsSuccessState(
            futureBidsEntity: FutureBidsEntity(
              data: data.data,
            ),
            futureBidsData: futureBidsData),
      );
    }, onError: (error) {
      log(
        error.toString(),
      );
      log("future bids error in cubit");
      // Navigator.pop(context);
      emit(
        BidsFailureState(
          errors: error,
          onRetry: () {},
        ),
      );
    });
  }
}
