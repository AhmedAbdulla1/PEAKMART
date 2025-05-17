import 'dart:async';
import 'dart:developer' as log;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/products/data/products_repo_imp.dart';
import 'package:peakmart/features/products/domain/entity/top_bidders_entity.dart';
import 'package:peakmart/features/products/domain/products_repo.dart';
import 'package:peakmart/features/products/presentation/state_m/top_bidders_cubit/top_bidder_states.dart';

class TopBidderCubit extends Cubit<TopBiddersState> {
  final ProductsRepo productsRepo = ProductsRepoImp();
  // final Map<int, List<TopBiddersData>> productBidders = {};
  Timer? _timer;
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

  void startAutoRefresh(int productId) {
    getTopBidders(productId: productId);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      getTopBidders(productId: productId);
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
