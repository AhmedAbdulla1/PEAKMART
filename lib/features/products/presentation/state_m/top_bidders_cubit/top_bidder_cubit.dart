import 'dart:developer' as log;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/products/data/products_repo_imp.dart';
import 'package:Bid_Mart/features/products/domain/entity/top_bidders_entity.dart';
import 'package:Bid_Mart/features/products/domain/products_repo.dart';
import 'package:Bid_Mart/features/products/presentation/state_m/top_bidders_cubit/top_bidder_states.dart';

class TopBidderCubit extends Cubit<TopBiddersState> {
  final ProductsRepo productsRepo = ProductsRepoImp();
  late TopBiddersEntity topBiddersEntity;

  TopBidderCubit() : super(TopBiddersInitialState());

  void getTopBidders({required int productId}) async {
    emit(TopBiddersLoadingState());

    final Result<AppErrors, TopBiddersEntity> result =
        await productsRepo.getTopBidders(productId);

    result.pick(
      onData: (data) {
        topBiddersEntity = data;
        log.log("in top bidders cubit data is ${topBiddersEntity.data}");
        log.log(
            "in top bidders cubit totalBidders is ${topBiddersEntity.totalBidders}");
        log.log(
            "in top bidders cubit totalEnrolled is ${topBiddersEntity.totalEnrolled}");

        emit(TopBiddersSuccessState(topBidders: topBiddersEntity));
      },
      onError: (error) {
        log.log("❌ خطأ أثناء جلب المزايدين للمنتج $productId: $error");
        emit(TopBiddersFailureState(
            errors: error,
            onRetry: () {
              getTopBidders(productId: productId);
            }));
      },
    );
  }

}