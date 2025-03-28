import 'dart:async';
import 'dart:developer' as log;
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/features/products/domain/entity/top_bidders_entity.dart';
import 'package:peakmart/features/products/presentation/state_m/top_bidders_cubit/states.dart';

class TopBidderCubit extends Cubit<TopBiddersState> {
  final Random _random = Random();
  final Map<int, List<TopBiddersData>> productBidders = {};
  Timer? _timer;

  TopBidderCubit() : super(TopBiddersInitialState());

  void getTopBidders({required int productId}) {
    emit(TopBiddersLoadingState());

    if (!productBidders.containsKey(productId)) {
      productBidders[productId] = [
        TopBiddersData(
            userName: "Ahmed Hassan",
            userPhoto: "assets/images/man1.jpg",
            bidderId: 20,
            bidAmount: 12300,
            productId: productId),
        TopBiddersData(
            userName: "Ali Mohamed",
            userPhoto: "assets/images/man2.webp",
            bidderId: 21,
            bidAmount: 5000,
            productId: productId),
        TopBiddersData(
            userName: "Karim Ahmed",
            userPhoto: "assets/images/man3.png",
            bidderId: 22,
            bidAmount: 7000,
            productId: productId),
      ];
    }

    List<TopBiddersData> bidders = List.from(productBidders[productId]!);

    // اختيار شخص عشوائي وزيادة سعره
    int randomIndex = _random.nextInt(bidders.length);
    bidders[randomIndex] = TopBiddersData(
      userPhoto: bidders[randomIndex].userPhoto,
      userName: bidders[randomIndex].userName,
      bidderId: bidders[randomIndex].bidderId,
      bidAmount: bidders[randomIndex].bidAmount + _random.nextInt(2000),
      productId: productId,
    );
    // Result<AppErrors, TopBiddersEntity> result =
    //     await productsRepo.getTopBidders(productId);

    // result.pick(onData: (data) {
    //   topBidders = data.data;
    //   log("data top Bidders in cubit: ${data.data}");

    //   log("Top Bidders in cubit: ${topBidders}");
    //   emit(TopBiddersSuccessState(topBidders: topBidders));
    // }, onError: (error) {
    //   log("Error in top Bidders cubit: ${error}");
    //   emit(TopBiddersFailureState(errors: error, onRetry: () {}));

    // إعادة الترتيب بناءً على السعر
    bidders.sort((a, b) => b.bidAmount.compareTo(a.bidAmount));
    productBidders[productId] = bidders;

    log.log("✅ تحديث مزايدين المنتج $productId: $bidders");

    emit(TopBiddersSuccessState(topBidders: List.from(bidders)));
  }

  void startAutoRefresh(int productId) {
    getTopBidders(productId: productId);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      getTopBidders(productId: productId);
    });
  }

  void reorderBidders(int oldIndex, int newIndex, int productId) {
    final bidders = List<TopBiddersData>.from(productBidders[productId]!);
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
