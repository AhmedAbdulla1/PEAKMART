

import 'package:dartz/dartz.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/app/network_info.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
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
  Future<Result<AppErrors, ProductsEntity>> getProducts() async {
    Result<AppErrors, ProductsEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, ProductsResponse> response =
        await _remoteDataSource.getProducts();
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
  Future<Result<AppErrors, ProductsEntity>> getProductsByCategory(int catId) async {
    Result<AppErrors, ProductsEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, ProductsResponse> response =
        await _remoteDataSource.getProductsByCategory(catId);
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
  Future<Result<AppErrors, TopBiddersEntity>> getTopBidders(int productId) async {
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
}
