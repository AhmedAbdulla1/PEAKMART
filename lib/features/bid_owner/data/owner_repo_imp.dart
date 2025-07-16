import 'dart:async';
import 'dart:developer';

import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/app/network_info.dart';
import 'package:Bid_Mart/core/entities/empty_entity.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/responses/emty_response.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:Bid_Mart/features/bid_owner/data/models/response/check_is_seller_response.dart';
import 'package:Bid_Mart/features/bid_owner/domain/entity/check_is_seller_entity.dart';
import 'package:Bid_Mart/features/bid_owner/domain/repository/owner_repo.dart';
import 'package:Bid_Mart/features/home/data/model/response/category_response.dart';
import 'package:Bid_Mart/features/home/domain/entity/category_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'remote_data_source.dart';

class OwnerRepoImp extends OwnerRepo {
  final OwnerDataSource _remoteDataSource = OwnerDataSource();
  final NetWorkInfo _networkInfo = instance<NetWorkInfo>();

  @override
  Future<Result<AppErrors, EmptyEntity>> addProduct(
      AddProductRequest addProductRequest) async {
    Result<AppErrors, EmptyEntity> result =
        Result(error: const AppErrors.connectionError());

    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, EmptyResponse> response =
            await _remoteDataSource.addProduct(addProductRequest);

        result = response.fold((error) {
          log("API Error: ${error.toString()}"); // ✅ طباعة الخطأ الحقيقي
          return Result(error: error);
        }, (response) {
          return Result(data: response.toEntity());
        });
      } catch (error, stacktrace) {
        debugPrint("Unexpected Error: $error");
        debugPrint(stacktrace.toString());
        result = Result(
            error: const AppErrors.responseError(
                message: "Unexpected error occurred"));
      }
    }

    return result;
  }

  @override
  Future<Result<AppErrors, CheckIsSellerEntity>> checkIsASeller() async {
    Result<AppErrors, CheckIsSellerEntity> result;

    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, CheckIsSellerResponse> response =
            await _remoteDataSource.checkIsASeller();
        result = response.fold((error) {
          return Result(error: error);
        }, (response) {
          return Result(data: response.toEntity());
        });
      } catch (error, stacktrace) {
        debugPrint("Unexpected Error: $error");
        debugPrint(stacktrace.toString());
        result = Result(
            error: const AppErrors.responseError(
                message: "Unexpected error occurred"));
      }
    } else {
      result = Result(error: const AppErrors.connectionError());
    }
    return result;
  }

  @override
  Future<Result<AppErrors, CategoriesEntity>> getCategories() async {
    Result<AppErrors, CategoriesEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, CategoriesResponse> response =
            await _remoteDataSource.getCategories();
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
}
