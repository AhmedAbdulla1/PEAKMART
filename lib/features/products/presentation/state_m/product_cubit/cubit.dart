import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bid_Mart/core/entities/empty_entity.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/products/data/models/request/bid_request.dart';
import 'package:Bid_Mart/features/products/data/models/request/enroll_request.dart';
import 'package:Bid_Mart/features/products/data/models/request/pagination_request.dart';
import 'package:Bid_Mart/features/products/data/products_repo_imp.dart';
import 'package:Bid_Mart/features/products/domain/entity/in_wishlist_entity.dart';
import 'package:Bid_Mart/features/products/domain/entity/prodcuts_entity.dart';
import 'package:Bid_Mart/features/products/domain/products_repo.dart';
import 'package:Bid_Mart/features/products/presentation/state_m/product_cubit/state.dart';

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
    Result<AppErrors, CheckWishlistEntity> isFavResult =
        results[1] as Result<AppErrors, CheckWishlistEntity>;
    late bool isFav;
    isFavResult.pick(onData: (data) {
      isFav = data.inWishlist;
    }, onError: (error) {
      isFav = false;
    });
    Result<AppErrors, ProductsEntity> result =
        results[0] as Result<AppErrors, ProductsEntity>;
    result.pick(onData: (data) {
      log("data: ${data.data}");
      log("show details of product id: $id");
      emit(ProductDetailsLoaded(product: data.data[0], isFav: isFav));
    }, onError: (error) {
      log("error: ${error.toString()}");
      emit(ProductError(
          error: CustomError(message: error.toString()), onRetry: () {}));
    });
  }
  Future<void> toggleFav(bool currentStatus,int productId)async{
    if(currentStatus){
      productsRepo.removeFromWishlist(productId);
    }else{
      productsRepo.addToWishlist(productId);
    }
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
