import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/products/data/products_repo_imp.dart';
import 'package:peakmart/features/products/domain/entity/prodcuts_entity.dart';
import 'package:peakmart/features/products/domain/products_repo.dart';
import 'package:peakmart/features/products/presentation/state_m/product_cubit/state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  ProductsRepo productsRepo = ProductsRepoImp();

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      Result<AppErrors, ProductsEntity> result =
          await productsRepo.getProducts();

      result.pick(onData: (data) {
        emit(ProductLoaded(products: data.data));
      }, onError: (error) {
        emit(ProductError(
            error: CustomError(message: error.toString()), onRetry: () {}));
      });
    } catch (e) {
      emit(ProductError(
          error: CustomError(message: e.toString()), onRetry: () {}));
    }
  }

  Future<void> getProductById(int id) async {
    emit(ProductLoading());
  }

  Future<void> fetchProductsByCategory(int catId) async {
    emit(ProductLoading());
    Result<AppErrors, ProductsEntity> result =
        await productsRepo.getProductsByCategory(catId);

    result.pick(onData: (data) {
      emit(ProductLoaded(products: data.data));
    }, onError: (error) {
      emit(ProductError(
          error: CustomError(message: error.toString()), onRetry: () {}));
    });
  }
}
