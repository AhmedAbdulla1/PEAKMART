import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/responses/product_response.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/profile/domain/enitiy/user_product_entity.dart';
import 'package:peakmart/features/profile/domain/profile_repo.dart';
import 'package:peakmart/features/profile/presentation/state_m/cart/state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final ProfileRepo profileRepo = instance<ProfileRepo>();

  Future<void> fetchProducts() async {
    emit(CartLoading());
    final products = [
      {
        "I_ID": 201,
        "ITEM_NAME": "aaaaa",
        "DESCRIPTION": "bbbbb",
        "STARTING_PRICE": "500.00",
        "PHOTO":
            "[\"https://picsum.photos/800/600\",\"https://picsum.photos/1800/600\",\"https://picsum.photos/800/1400\",\"https://picsum.photos/1080/600\"]",
        "START_DATE": "2025-02-27",
        "END_DATE": "2025-03-07",
        "STATUS": "not_ended"
      },
      {
        "I_ID": 163,
        "ITEM_NAME": "Pulse Oximeter 2025",
        "DESCRIPTION":
            "Compact pulse oximeter for measuring blood oxygen levels.",
        "STARTING_PRICE": "25.00",
        "PHOTO": null,
        "START_DATE": "2025-05-10",
        "END_DATE": "2025-05-20",
        "STATUS": "not_ended"
      },
      {
        "I_ID": 121,
        "ITEM_NAME": "Smartphone",
        "DESCRIPTION": "Latest smartphone with advanced features.",
        "STARTING_PRICE": "500.00",
        "PHOTO": null,
        "START_DATE": "2025-06-10",
        "END_DATE": "2025-06-20",
        "STATUS": "ended"
      },
    ];
    try {
      // Simulate fetching profile data from an API
      Result<AppErrors, UserProductEntity> result =
          await profileRepo.getUserProducts();
      result.pick(onData: (data) {
        emit(
          CartLoaded(products: data.data),
        );
      }, onError: (error) {
        log(
          error.toString(),
        );
        // Navigator.pop(context);
        emit(
          CartError(
            error: error,
            onRetry: () {},
          ),
        );
        List<ProductResponse> productsList =
            products.map((e) => ProductResponse.fromJson(e)).toList();
        List<ProductEntity> productsEntity =
            productsList.map((e) => e.toEntity()).toList();
        emit(CartLoaded(products: productsEntity));
      });
    } catch (e) {
      emit(CartError(
          error:
              const AppErrors.customError(message: 'Failed to fetch profile'),
          onRetry: () {
            fetchProducts();
          }));
    }
  }

  Future<void> getProductById(int id) async {
    emit(CartLoading());
  }
}
