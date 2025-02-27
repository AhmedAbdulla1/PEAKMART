import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/responses/product_response.dart';
import 'package:peakmart/features/products/presentation/state_m/product_details_cubit/state.dart';

class ProductDetailsCubit extends Cubit<ProductState> {
  ProductDetailsCubit() : super(ProductInitial());

  Future<void> fetchProductData() async {
    emit(ProductLoading());
    try {
      final products =
        {
          "id": 1,
          "name": "The Luxe Houndstooth Lounge Chair",
          "imageUrl": "assets/images/card.png",
          "endDate": "November 1, 2024",
          "peopleRolledIn": 15,
          "price": 2000.0,
          "isEnded": false
        };
      ProductResponse productsList = ProductResponse.fromJson(products);

      Future.delayed(const Duration(milliseconds: 500))
          .then((value) => emit(ProductLoaded(products: productsList.toEntity())));
    } catch (e) {
      emit(ProductError(
          error: CustomError(message: e.toString()), onRetry: () {}));
    }
  }

  Future<void> getProductById(int id) async {
    emit(ProductLoading());
  }
}
