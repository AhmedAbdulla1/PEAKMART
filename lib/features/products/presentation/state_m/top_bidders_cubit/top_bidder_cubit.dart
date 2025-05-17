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
  final Map<int, List<TopBiddersData>> productBidders = {};
  Timer? _timer;

  TopBidderCubit() : super(TopBiddersInitialState());

  void getTopBidders({required int productId}) async {
    emit(TopBiddersLoadingState());

    final Result<AppErrors, TopBiddersEntity> result =
        await productsRepo.getTopBidders(productId);

    result.pick(
      onData: (data) {
        final topBidders = data.data;

        // حفظ البيانات مؤقتاً إن احتجت لاحقاً
        productBidders[productId] = topBidders;

        log.log("✅ تم جلب المزايدين للمنتج $productId: $topBidders");

        emit(TopBiddersSuccessState(topBidders: topBidders));
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

  void reorderBidders(int oldIndex, int newIndex, int productId) {
    final bidders = List<TopBiddersData>.from(productBidders[productId] ?? []);
    final item = bidders.removeAt(oldIndex);
    bidders.insert(newIndex, item);
    productBidders[productId] = bidders;
    emit(TopBiddersSuccessState(topBidders: List.from(bidders)));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
