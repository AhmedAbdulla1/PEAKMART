import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/products/data/products_repo_imp.dart';
import 'package:peakmart/features/products/domain/entity/top_bidders_entity.dart';
import 'package:peakmart/features/products/domain/products_repo.dart';
import 'package:peakmart/features/products/presentation/state_m/top_bidders_cubit/states.dart';

class TopBidderCubit extends Cubit<TopBiddersState> {
  ProductsRepo productsRepo = ProductsRepoImp();
  List<TopBiddersData> topBidders = [];

  TopBidderCubit() : super(TopBiddersInitialState());

  Future<void> getTopBidders({required int productId}) async {
    emit(TopBiddersLoadingState());

    Result<AppErrors, TopBiddersEntity> result =
        await productsRepo.getTopBidders(productId);

    result.pick(onData: (data) {
      topBidders = data.data;
      log("data top Bidders in cubit: ${data.data}");

      log("Top Bidders in cubit: ${topBidders}");
      emit(TopBiddersSuccessState(topBidders: topBidders));
    }, onError: (error) {
      log("Error in top Bidders cubit: ${error}");
      emit(TopBiddersFailureState(errors: error, onRetry: () {}));
    });
  }

  void updateTopBidders(List<TopBiddersData> newBidders) {
    topBidders = newBidders;
    emit(TopBiddersSuccessState(topBidders: topBidders));
  }
}
