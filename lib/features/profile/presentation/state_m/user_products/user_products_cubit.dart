import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/profile/data/models/request/cancle_user_product_request.dart';
import 'package:peakmart/features/profile/domain/enitiy/product_enrolled_entity.dart';
import 'package:peakmart/features/profile/domain/enitiy/user_product_entity.dart';
import 'package:peakmart/features/profile/domain/enitiy/user_products_enrolled_entity.dart';
import 'package:peakmart/features/profile/domain/profile_repo.dart';
import 'package:peakmart/features/profile/presentation/state_m/user_products/user_products_states.dart';

class UserProductsCubit extends Cubit<UserProductsStates> {
  UserProductsCubit() : super(UserProductsInitial());
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
  final ProfileRepo profileRepo = instance<ProfileRepo>();

  bool _uploadedLoaded = false;
  bool _enrolledLoaded = false;

  List<ProductEntity> uploadedProducts = [];
  List<ProductsEnrolledEntity> enrolledProducts = [];

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
        // handle error + fallback
        emit(UserProductsError(error: error, onRetry: getUploadedProducts));
      });
    } catch (_) {
      emit(UserProductsError(
          error: const AppErrors.customError(message: 'Upload fetch failed'),
          onRetry: getUploadedProducts));
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
        log("In getEnrolledProducts cubit data: $enrolledProducts");
        emit(ProductsEnrolledLoaded(products: enrolledProducts));
      }, onError: (error) {
        log("In getEnrolledProducts cubit error: $error");
        emit(UserProductsError(error: error, onRetry: getEnrolledProducts));
      });
    } catch (_) {
      log("In getEnrolledProducts cubit error: $_");
      emit(UserProductsError(
          error: const AppErrors.customError(message: 'Enroll fetch failed'),
          onRetry: getEnrolledProducts));
    }
  }

  Future<void> cancelProduct(
      {required int productId, required String password}) async {
    emit(CancelUserProductLoading());
    Result<AppErrors, EmptyEntity> result =
        await profileRepo.cancelUserProduct(CancelUserProductRequest(
      productId: productId,
      password: password,
      status: "canceled",
    ));
    result.pick(onData: (data) {
      log("In cancelOrEndProduct cubit data: $data");
      log("id: $productId,password: $password, status: canceled");

      emit(CancelUserProductSuccess());
      getUploadedProducts();
    }, onError: (error) {
      log("In cancelOrEndProduct cubit error: $error");
      emit(CancelUserProductFailed(error: error));
    });
  }

  Future<void> endProduct(
      {required int productId, required String password}) async {
    emit(CancelUserProductLoading());
    Result<AppErrors, EmptyEntity> result =
        await profileRepo.cancelUserProduct(CancelUserProductRequest(
      productId: productId,
      password: password,
      status: "ended",
    ));
    result.pick(onData: (data) {
      log("In cancelOrEndProduct cubit data: $data");
      log("id: $productId,password: $password, status: ended");
      emit(EndUserProductSuccess());
      getUploadedProducts();
    }, onError: (error) {
      log("In cancelOrEndProduct cubit error: $error");
      emit(CancelUserProductFailed(error: error));
    });
  }
}
