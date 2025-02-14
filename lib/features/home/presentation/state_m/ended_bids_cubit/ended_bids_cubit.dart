import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/home/domain/entity/ended_bids_entity.dart';
import 'package:peakmart/features/home/domain/home_repo.dart';
import 'package:peakmart/features/home/presentation/state_m/bid_work_now_cubit/bid_work_now_cubit.dart';

class EndedBidsCubit extends Cubit<BidsState> {
  HomeRepository homeRepository = instance<HomeRepository>();
  List<EndedBidsData> endedBidsData = [];

  EndedBidsCubit() : super(BidsInitialState());
  Future<void> getEndedBids() async {
    emit(
      BidsLoadingState(),
    );

    Result<AppErrors, EndedBidsEntity> result =
        await homeRepository.getEndedBids();

    result.pick(onData: (data) {
     endedBidsData = data.data;
      debugPrint(
        'Ended bids data list in cubit is $endedBidsData',
      );
      // Navigator.pop(context);
      emit(
        BidsSuccessState(
            endedBidsEntity: EndedBidsEntity(
          data: data.data,
        ),
            endedBidsData: endedBidsData),
      );
    }, onError: (error) {
      log(
        error.toString(),
      );
      log("ended bids error in cubit");
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
