import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/responses/product_response.dart';
import 'package:peakmart/features/products/data/models/product_model.dart';
import 'package:peakmart/features/products/presentation/state_m/product_cubit/state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final products = [
        {
          "I_ID": 201,
          "ITEM_NAME": "aaaaa",
          "DESCRIPTION": "bbbbb",
          "STARTING_PRICE": "500.00",
          "PHOTO": "[\"https://picsum.photos/800/600\",\"https://picsum.photos/1800/600\",\"https://picsum.photos/800/1400\",\"https://picsum.photos/1080/600\"]",
          "START_DATE": "2025-02-27",
          "END_DATE": "2025-03-07",
          "STATUS": "not_ended"
        },
        {
          "I_ID": 163,
          "ITEM_NAME": "Pulse Oximeter 2025",
          "DESCRIPTION": "Compact pulse oximeter for measuring blood oxygen levels.",
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
      List<ProductResponse> productsList =
          products.map((e) => ProductResponse.fromJson(e)).toList();
      List<ProductEntity> productsEntity = productsList.map((e) => e.toEntity()).toList();
      Future.delayed(const Duration(milliseconds: 500))
          .then((value) => emit(ProductLoaded(products: productsEntity)));
    } catch (e) {
      emit(ProductError(
          error: CustomError(message: e.toString()), onRetry: () {}));
    }
  }

  Future<void> getProductById(int id) async {
    emit(ProductLoading());
  }
}
