import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/features/home/presentation/state_m/random_products_cubit/random_products_states.dart';

class RandomProductsCubit extends Cubit<RandomProductsState> {
  List<ProductEntity> allProducts = [];

  RandomProductsCubit() : super(RandomProductsInitialState());
  void showRandomProducts({required List<ProductEntity> allProducts}) {
    try {
      emit(RandomProductsLoadingState());

      debugPrint("In random cubit All products: $allProducts");
      debugPrint("📢 جميع المنتجات قبل العشوائية: ${allProducts.length}");

      if (allProducts.isEmpty) {
        emit(RandomProductsFailureState(
          errors: const AppErrors.customError(message: "لا توجد منتجات متاحة"),
          onRetry: () => showRandomProducts(allProducts: allProducts),
        ));
        return;
      }
      allProducts.shuffle(Random());
      final randomProducts = allProducts.take(20).toList();

      debugPrint("✅ تم اختيار ${randomProducts.length} منتج عشوائي");

      emit(RandomProductsSuccessState(randomProducts: randomProducts));
    } catch (error) {
      emit(RandomProductsFailureState(
        errors: const AppErrors.customError(message: "ERROR"),
        onRetry: () => showRandomProducts(allProducts: allProducts),
      ));
    }
  }
}
