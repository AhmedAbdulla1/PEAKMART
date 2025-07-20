import 'dart:developer';

import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/app/network_info.dart';
import 'package:Bid_Mart/core/entities/empty_entity.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/responses/emty_response.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/profile/data/models/request/cancle_user_product_request.dart';
import 'package:Bid_Mart/features/profile/data/models/request/own_product_request.dart';
import 'package:Bid_Mart/features/profile/data/models/request/update_profile_image_request.dart';
import 'package:Bid_Mart/features/profile/data/models/request/update_profile_request.dart';
import 'package:Bid_Mart/features/profile/data/models/response/user_info_response.dart';
import 'package:Bid_Mart/features/profile/data/models/response/user_product_response.dart';
import 'package:Bid_Mart/features/profile/data/models/response/user_products_enrolled_response.dart';
import 'package:Bid_Mart/features/profile/data/remote_data_source.dart';
import 'package:Bid_Mart/features/profile/domain/enitiy/user_info_entity.dart';
import 'package:Bid_Mart/features/profile/domain/enitiy/user_product_entity.dart';
import 'package:Bid_Mart/features/profile/domain/enitiy/user_products_enrolled_entity.dart';
import 'package:Bid_Mart/features/profile/domain/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ProfileDataSource _remoteDataSource = ProfileDataSource();
  final NetWorkInfo _networkInfo = instance<NetWorkInfo>();

  @override
  Future<Result<AppErrors, UserInfoEntity>> getUserInfo() async {
    Result<AppErrors, UserInfoEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, UserInfoResponse> response =
            await _remoteDataSource.getUserInfo();
        result = response.fold((error) {
          return Result(error: error);
        }, (response) {
          return Result(data: response.toEntity());
        });
      } catch (error) {
        result = Result(error: const AppErrors.responseError());
      }
    } else {
      result = Result(error: const AppErrors.connectionError());
    }
    return result;
  }

  @override
  Future<Result<AppErrors, UserProductEntity>> getProductsUploaded() async {
    Result<AppErrors, UserProductEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, UserProductResponse> response =
            await _remoteDataSource.getProductsUploaded();
        result = response.fold((error) {
          return Result(error: error);
        }, (response) {
          return Result(data: response.toEntity());
        });
      } catch (error) {
        result = Result(error: const AppErrors.responseError());
      }
    } else {
      result = Result(error: const AppErrors.connectionError());
    }
    return result;
  }

  @override
  Future<Result<AppErrors, UserProductsEnrolledEntity>>
      getProductsEnrolled() async {
    Result<AppErrors, UserProductsEnrolledEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, UserProductsEnrolledResponse> response =
            await _remoteDataSource.getProductsEnrolled();
        result = response.fold((error) {
          return Result(error: error);
        }, (response) {
          return Result(data: response.toEntity());
        });
      } catch (error) {
        result = Result(error: const AppErrors.responseError());
      }
    } else {
      result = Result(error: const AppErrors.connectionError());
    }
    return result;
  }

  @override
  Future<Result<AppErrors, EmptyEntity>> cancelUserProduct(
      CancelUserProductRequest cancleProductRequest) async {
    Result<AppErrors, EmptyEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, EmptyResponse> response =
            await _remoteDataSource.cancelUserProducts(cancleProductRequest);
        result = response.fold((error) {
          return Result(error: error);
        }, (response) {
          return Result(data: response.toEntity());
        });
      } catch (error) {
        result = Result(error: const AppErrors.responseError());
      }
    } else {
      result = Result(error: const AppErrors.connectionError());
    }
    return result;
  }

  @override
  Future<Result<AppErrors, EmptyEntity>> updateProfile(
      UpdateProfileRequest updateProfileRequest) async {
    Result<AppErrors, EmptyEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, EmptyResponse> response =
            await _remoteDataSource.updateProfile(updateProfileRequest);
        result = response.fold((error) {
          log("Error in profile repo: $error");
          return Result(error: error);
        }, (response) {
          log("Response in profile repo: $response");
          return Result(data: response.toEntity());
        });
      } catch (error) {
        result = Result(error: const AppErrors.responseError());
      }
    } else {
      result = Result(error: const AppErrors.connectionError());
    }
    return result;
  }

  @override
  Future<Result<AppErrors, EmptyEntity>> updateProfileImage(
      UpdateProfileImageRequest updateProfileImageRequest) async {
    Result<AppErrors, EmptyEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, EmptyResponse> response = await _remoteDataSource
            .updaterProfileImage(updateProfileImageRequest);
        debugPrint('response: $response');

        result = response.fold((error) {
          return Result(error: error);
        }, (response) {
          return Result(data: response.toEntity());
        });
      } catch (error) {
        result = Result(error: const AppErrors.responseError());
      }
    } else {
      result = Result(error: const AppErrors.connectionError());
    }
    return result;
  }

  @override
  Future<Result<AppErrors, UserProductEntity>> getWishListProducts() async {
    Result<AppErrors, UserProductEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, UserProductResponse> response =
            await _remoteDataSource.getWishlistProducts();
        result = response.fold((error) {
          return Result(error: error);
        }, (response) {
          return Result(data: response.toEntity());
        });
      } catch (error) {
        result = Result(error: const AppErrors.responseError());
      }
    } else {
      result = Result(error: const AppErrors.connectionError());
    }
    return result;
  }

  @override
  Future<Result<AppErrors, EmptyEntity>> ownProducts(
      OwnProductRequest ownProductsRequest) async {
    Result<AppErrors, EmptyEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, EmptyResponse> response =
            await _remoteDataSource.ownProduct(ownProductsRequest);
        result = response.fold((error) {
          return Result(error: error);
        }, (response) {
          return Result(data: response.toEntity());
        });
      } catch (error) {
        result = Result(error: const AppErrors.responseError());
      }
    } else {
      result = Result(error: const AppErrors.connectionError());
    }
    return result;
  }

  @override
  Future<Result<AppErrors, EmptyEntity>> logout() async {
    if (!await _networkInfo.isConnected) {
      log("❌ No internet connection");
      return Result(error: const AppErrors.connectionError());
    }

    try {
      Either<AppErrors, EmptyResponse> response =
          await _remoteDataSource.logout();

      return response.fold(
        (error) {
          log("⚠️ Error in profile repo: $error");
          return Result(error: error);
        },
        (data) {
          log("✅ Logout successful: $data");
          return Result(data: data.toEntity());
        },
      );
    } catch (error, stack) {
      log("❌ Exception in logout(): $error");
      log("📌 StackTrace: $stack");
      return Result(
        error: AppErrors.responseError(
          message: error.toString().isNotEmpty
              ? error.toString()
              : 'Unknown logout error',
        ),
      );
    }
  }
}
