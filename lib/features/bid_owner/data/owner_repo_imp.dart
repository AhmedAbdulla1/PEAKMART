import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/app/network_info.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:peakmart/features/bid_owner/data/models/response/add_product_response.dart';
import 'package:peakmart/features/bid_owner/domain/entity/add_product_entity.dart';
import 'package:peakmart/features/bid_owner/domain/repository/owner_repo.dart';

import 'remote_data_source.dart';

class OwnerRepoImp extends OwnerRepo {
  final OwnerDataSource _remoteDataSource = OwnerDataSource();
  final NetWorkInfo _networkInfo = instance<NetWorkInfo>();

  @override
  Future<Result<AppErrors, AddProductEntity>> addProduct(
      AddProductRequest addProductRequest) async {
    Result<AppErrors, AddProductEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, AddProductResponse> response =
            await _remoteDataSource.addProduct(addProductRequest);
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
