import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/entities/empty_entity.dart';
import 'package:Bid_Mart/core/entities/prodcut_entity.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/profile/data/models/request/cancle_user_product_request.dart';
import 'package:Bid_Mart/features/profile/domain/enitiy/product_enrolled_entity.dart';
import 'package:Bid_Mart/features/profile/domain/enitiy/user_product_entity.dart';
import 'package:Bid_Mart/features/profile/domain/enitiy/user_products_enrolled_entity.dart';
import 'package:Bid_Mart/features/profile/domain/profile_repo.dart';
import 'package:Bid_Mart/features/profile/presentation/state_m/user_products/user_products_states.dart';

class UserProductsCubit extends Cubit<UserProductsStates> {
  UserProductsCubit() : super(UserProductsInitial());

  final ProfileRepo profileRepo = instance<ProfileRepo>();

  bool _uploadedLoaded = false;
  bool _enrolledLoaded = false;
  bool _wishlistLoaded = false;

  List<ProductEntity> uploadedProducts = [];
  List<ProductsEnrolledEntity> enrolledProducts = [];
  List<ProductEntity> wishListProducts = [];

  void resetEnrolledProducts() {
    _enrolledLoaded = false;
    enrolledProducts = [];
  }

  void restWishListPram() {
    _wishlistLoaded = false;
    wishListProducts = [];
  }

  void resetUploadedProducts() {
    _uploadedLoaded = false;
    uploadedProducts = [];
  }

  Future<void> getUploadedProducts() async {
    if (_uploadedLoaded) {
      emit(UserProductsLoaded(products: uploadedProducts));
      return;
    }

    emit(ProductUploadedLoading());
    try {
      Result<AppErrors, UserProductEntity> result =
          await profileRepo.getProductsUploaded();
      result.pick(onData: (data) {
        _uploadedLoaded = true;
        uploadedProducts = data.data;
        emit(UserProductsLoaded(products: uploadedProducts));
      }, onError: (error) {
        emit(UserProductsError(error: error, onRetry: getUploadedProducts));
      });
    } catch (_) {
      emit(UserProductsError(
        error: const AppErrors.customError(message: 'Upload fetch failed'),
        onRetry: getUploadedProducts,
      ));
    }
  }

  Future<void> getEnrolledProducts() async {
    if (_enrolledLoaded) {
      emit(ProductsEnrolledLoaded(products: enrolledProducts));
      return;
    }

    emit(ProductsEnrolledLoading());
    try {
      Result<AppErrors, UserProductsEnrolledEntity> result =
          await profileRepo.getProductsEnrolled();
      result.pick(onData: (data) {
        _enrolledLoaded = true;
        enrolledProducts = data.data;
        emit(ProductsEnrolledLoaded(products: enrolledProducts));
      }, onError: (error) {
        emit(ProductEnrolledError(error: error, onRetry: getEnrolledProducts));
      });
    } catch (_) {
      emit(ProductEnrolledError(
        error: const AppErrors.customError(message: 'Enroll fetch failed'),
        onRetry: getEnrolledProducts,
      ));
    }
  }

  Future<void> getWishListProducts() async {
    if (_wishlistLoaded) {
      emit(WishListLoaded(products: wishListProducts));
      return;
    }

    emit(WishListLoading());
    try {
      Result<AppErrors, UserProductEntity> result =
          await profileRepo.getWishListProducts();
      result.pick(onData: (data) {
        _wishlistLoaded = true;
        wishListProducts = data.data;
        emit(WishListLoaded(products: data.data));
      }, onError: (error) {
        emit(WishlistError(error: error, onRetry: getWishListProducts));
      });
    } catch (_) {
      emit(WishlistError(
        error: const AppErrors.customError(message: 'Wishlist fetch failed'),
        onRetry: getWishListProducts,
      ));
    }
  }

  Future<void> cancelProduct({
    required int productId,
    required String password,
  }) async {
    emit(CancelUserProductLoading());
    Result<AppErrors, EmptyEntity> result =
        await profileRepo.cancelUserProduct(CancelUserProductRequest(
      productId: productId,
      password: password,
      status: "canceled",
    ));
    result.pick(onData: (data) {
      emit(CancelUserProductSuccess());
      resetUploadedProducts();
      getUploadedProducts();
    }, onError: (error) {
      emit(CancelUserProductFailed(error: error));
    });
  }

  Future<void> endProduct({
    required int productId,
    required String password,
  }) async {
    emit(CancelUserProductLoading());
    Result<AppErrors, EmptyEntity> result =
        await profileRepo.cancelUserProduct(CancelUserProductRequest(
      productId: productId,
      password: password,
      status: "ended",
    ));
    result.pick(onData: (data) {
      emit(EndUserProductSuccess());
      resetUploadedProducts();
      getUploadedProducts();
    }, onError: (error) {
      emit(CancelUserProductFailed(error: error));
    });
  }
}
