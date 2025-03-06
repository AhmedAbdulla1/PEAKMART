import 'package:dartz/dartz.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/app/network_info.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/profile/data/models/response/user_info_response.dart';
import 'package:peakmart/features/profile/data/models/response/user_product_response.dart';
import 'package:peakmart/features/profile/data/remote_data_source.dart';
import 'package:peakmart/features/profile/domain/enitiy/user_info_entity.dart';
import 'package:peakmart/features/profile/domain/enitiy/user_product_entity.dart';
import 'package:peakmart/features/profile/domain/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo{

  final ProfileDataSource _remoteDataSource = ProfileDataSource();
  final NetWorkInfo _networkInfo = instance<NetWorkInfo>();

  @override
  Future<Result<AppErrors, UserInfoEntity>> getUserInfo() async{
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
  Future<Result<AppErrors, UserProductEntity>> getUserProducts()async {
    Result<AppErrors, UserProductEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, UserProductResponse> response =
            await _remoteDataSource.getUserProducts();
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