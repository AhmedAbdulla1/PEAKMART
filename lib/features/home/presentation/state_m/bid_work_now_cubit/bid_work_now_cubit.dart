import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/home/domain/entity/bid_work_now_entity.dart';
import 'package:peakmart/features/home/domain/entity/ended_bids_entity.dart';
import 'package:peakmart/features/home/domain/home_repo.dart';

part '../states.dart';

class BidWorkNowCubit extends Cubit<BidsState> {
  HomeRepository homeRepository = instance<HomeRepository>();
   List<BidWorkNowData> bidWorkNowData=[];
  BidWorkNowCubit() : super(BidsInitialState());
  Future<void> getBidWorkNow() async {
    emit(
      BidsLoadingState(),
    );

    Result<AppErrors, BidWorkNowEntity> result =
        await homeRepository.getBidWorkNow();

    result.pick(onData: (data) {
      bidWorkNowData = data.data;
      debugPrint(
        'Bid work now data list in cubit is $bidWorkNowData',
      );
      // Navigator.pop(context);
      emit(
        BidsSuccessState(
            bidWorkNowEntity: BidWorkNowEntity(
              data: data.data,
            ),
            bidWorkNowData: bidWorkNowData),
      );
    }, onError: (error) {
      log(
        error.toString(),
      );
      log("bid work now error in cubit");
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
