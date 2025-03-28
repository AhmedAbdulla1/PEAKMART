import 'package:dartz/dartz.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/app/network_info.dart';
import 'package:peakmart/core/responses/emty_response.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/auth/data/data_source.dart';
import 'package:peakmart/features/auth/data/model/request/login_request.dart';
import 'package:peakmart/features/auth/data/model/request/rest_password_request.dart';
import 'package:peakmart/features/auth/data/model/response/login_response.dart';
import 'package:peakmart/features/auth/domain/entity/login_entity.dart';
import 'package:peakmart/features/auth/domain/repository/auth_repo.dart';

class AuthRepositoryImp implements AuthRepo {
  final AuthDataSource _authDataSource = AuthDataSource();
  final NetWorkInfo _networkInfo = instance<NetWorkInfo>();

  @override
  Future<Result<AppErrors, LoginEntity>> login(
      LoginRequest loginRequest) async {
    Result<AppErrors, LoginEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, LoginResponse> response =
            await _authDataSource.login(loginRequest);
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
  Future<Result<AppErrors, EmptyEntity>> restPassword(RestPasswordRequest resetPassword)async {
    Result<AppErrors, EmptyEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, EmptyResponse> response =
            await _authDataSource.restPassword(resetPassword);
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
