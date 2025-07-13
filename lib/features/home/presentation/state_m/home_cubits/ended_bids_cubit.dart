import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/entities/prodcut_entity.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/home/domain/entity/ended_bids_entity.dart';
import 'package:Bid_Mart/features/home/domain/home_repo.dart';
import 'package:Bid_Mart/features/home/presentation/state_m/home_cubits/states.dart';

class EndedBidsCubit extends Cubit<BidsState> {
  HomeRepository homeRepository = instance<HomeRepository>();
  List<ProductEntity> endedBidsData = [];

  EndedBidsCubit() : super(BidsInitialState());

  Future<void> getEndedBids() async {
    emit(BidsLoadingState());

    Result<AppErrors, EndedBidsEntity> result =
        await homeRepository.getEndedBids();

    result.pick(onData: (data) {
      endedBidsData = data.data;
      emit(EndedBidsSuccessState(endedBidsData: endedBidsData));
    }, onError: (error) {
      emit(BidsFailureState(errors: error, onRetry: getEndedBids));
    });
  }
}
