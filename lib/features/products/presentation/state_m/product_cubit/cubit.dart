import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/products/data/models/request/bid_request.dart';
import 'package:peakmart/features/products/data/models/request/enroll_request.dart';
import 'package:peakmart/features/products/data/models/request/pagination_request.dart';
import 'package:peakmart/features/products/data/products_repo_imp.dart';
import 'package:peakmart/features/products/domain/entity/prodcuts_entity.dart';
import 'package:peakmart/features/products/domain/products_repo.dart';
import 'package:peakmart/features/products/presentation/state_m/product_cubit/state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  ProductsRepo productsRepo = ProductsRepoImp();

  Future<void> fetchProducts({
    required int page,
  }) async {
    emit(ProductLoading());
    try {
      Result<AppErrors, ProductsEntity> result = await productsRepo.getProducts(
        getProductsPaginationRequest: PaginationRequest(
          page: page,
          limit: 10,
        ),
      );

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

  Future<void> getProductById({required int id}) async {
    emit(ProductLoading());
    final results = await Future.wait([
      productsRepo.getProductById(id),
      productsRepo.checkProductInWishList(id)
    ]);
    Result<AppErrors, ProductsEntity> result =
        results[0] as Result<AppErrors, ProductsEntity>;
    result.pick(onData: (data) {
      log("data: ${data.data}");
      log("show details of product id: $id");
      emit(ProductDetailsLoaded(product: data.data[0]));
    }, onError: (error) {
      log("error: ${error.toString()}");
      emit(ProductError(
          error: CustomError(message: error.toString()), onRetry: () {}));
    });
  }

  Future<void> fetchProductsByCategory(
      {required int catId, required int page}) async {
    emit(ProductLoading());
    Result<AppErrors, ProductsEntity> result = await productsRepo
        .getProductsByCategory(catId, PaginationRequest(page: page, limit: 10));

    result.pick(onData: (data) {
      emit(ProductLoaded(products: data.data));
    }, onError: (error) {
      emit(ProductError(
          error: CustomError(message: error.toString()), onRetry: () {}));
    });
  }

  Future<void> enrollProduct(EnrollRequest enrollRequest) async {
    Result<AppErrors, EmptyEntity> result =
        await productsRepo.enrollProduct(enrollRequest);
    result.pick(onData: (data) {
      return;
    }, onError: (error) {
      emit(ProductError(
          error: CustomError(message: error.toString()), onRetry: () {}));
    });
  }

  Future<void> bidProduct(BidRequest bidRequest) async {
    Result<AppErrors, EmptyEntity> result =
        await productsRepo.bidProduct(bidRequest);
    result.pick(onData: (data) {
      return;
    }, onError: (error) {
      emit(ProductError(
          error: CustomError(message: error.toString()), onRetry: () {}));
    });
  }
}
