import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/app/network_info.dart';
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/responses/emty_response.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/products/data/models/request/bid_request.dart';
import 'package:peakmart/features/products/data/models/request/enroll_request.dart';
import 'package:peakmart/features/products/data/models/request/pagination_request.dart';
import 'package:peakmart/features/products/data/models/response/products_response.dart';
import 'package:peakmart/features/products/data/models/response/top_bidders_response.dart';
import 'package:peakmart/features/products/data/products_data_source.dart';
import 'package:peakmart/features/products/domain/entity/prodcuts_entity.dart';
import 'package:peakmart/features/products/domain/entity/top_bidders_entity.dart';
import 'package:peakmart/features/products/domain/products_repo.dart';

class ProductsRepoImp extends ProductsRepo {
  final ProductsDataSource _remoteDataSource = ProductsDataSource();
  final NetWorkInfo _networkInfo = instance<NetWorkInfo>();

  @override
  Future<Result<AppErrors, ProductsEntity>> getProducts({
    required PaginationRequest getProductsPaginationRequest,
  }) async {
    Result<AppErrors, ProductsEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, ProductsResponse> response =
            await _remoteDataSource.getProducts(getProductsPaginationRequest);
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
  Future<Result<AppErrors, ProductsEntity>> getProductById(
      int productId) async {
    {
      Result<AppErrors, ProductsEntity> result;
      if (await _networkInfo.isConnected) {
        try {
          Either<AppErrors, ProductsResponse> response =
              await _remoteDataSource.getProductById(productId);
          result = response.fold((error) {
            return Result(error: error);
          }, (response) {
            log("in repo impl ${response.toString()}");
            return Result(data: response.toEntity());
          });
        } catch (error) {
          log("in repo impl ${error.toString()}");
          result = Result(error: const AppErrors.responseError());
        }
      } else {
        result = Result(error: const AppErrors.connectionError());
      }
      return result;
    }
  }

  @override
  Future<Result<AppErrors, ProductsEntity>> getProductsByCategory(
      int catId, PaginationRequest getProductsPaginationRequest) async {
    Result<AppErrors, ProductsEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, ProductsResponse> response = await _remoteDataSource
            .getProductsByCategory(catId, getProductsPaginationRequest);
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
  Future<Result<AppErrors, TopBiddersEntity>> getTopBidders(
      int productId) async {
    Result<AppErrors, TopBiddersEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, TopBiddersResponse> response =
            await _remoteDataSource.getTopBidders(productId);
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
  Future<Result<AppErrors, EmptyEntity>> enrollProduct(
      EnrollRequest enroll) async {
    Result<AppErrors, EmptyEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, EmptyResponse> response =
            await _remoteDataSource.enroll(enroll);
        log('in repo impl ${response.toString()}',name: 'bidProduct');

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
  Future<Result<AppErrors, EmptyEntity>> bidProduct(BidRequest enroll) async {
    Result<AppErrors, EmptyEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, EmptyResponse> response =
            await _remoteDataSource.bid(enroll);
        log('in repo impl ${response.toString()}',name: 'bidProduct');
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
