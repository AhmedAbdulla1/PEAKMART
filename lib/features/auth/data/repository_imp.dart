import 'dart:developer';

import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/app/network_info.dart';
import 'package:Bid_Mart/core/entities/empty_entity.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/responses/emty_response.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/auth/data/data_source.dart';
import 'package:Bid_Mart/features/auth/data/model/request/login_request.dart';
import 'package:Bid_Mart/features/auth/data/model/request/register_request.dart';
import 'package:Bid_Mart/features/auth/data/model/request/rest_password_request.dart';
import 'package:Bid_Mart/features/auth/data/model/request/seller_info_request.dart';
import 'package:Bid_Mart/features/auth/data/model/request/send_otp_request.dart';
import 'package:Bid_Mart/features/auth/data/model/request/signup_for_bid_request.dart';
import 'package:Bid_Mart/features/auth/data/model/request/verfiy_otp_request.dart';
import 'package:Bid_Mart/features/auth/data/model/response/login_response.dart';
import 'package:Bid_Mart/features/auth/data/model/response/register_response.dart';
import 'package:Bid_Mart/features/auth/data/model/response/send_otp_response.dart';
import 'package:Bid_Mart/features/auth/domain/entity/login_entity.dart';
import 'package:Bid_Mart/features/auth/domain/entity/register_entity.dart';
import 'package:Bid_Mart/features/auth/domain/entity/send_otp_entity.dart';
import 'package:Bid_Mart/features/auth/domain/repository/auth_repo.dart';
import 'package:dartz/dartz.dart';

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
  Future<Result<AppErrors, EmptyEntity>> restPassword(
      RestPasswordRequest resetPassword) async {
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

  @override
  Future<Result<AppErrors, RegisterEntity>> register(
      RegisterRequest registerRequest) async {
    Result<AppErrors, RegisterEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, RegisterResponse> response =
            await _authDataSource.register(registerRequest);
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
  Future<Result<AppErrors, SendOtpEntity>> sendOtp(
      SendOtpRequest sendOtpRequest) async {
    Result<AppErrors, SendOtpEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, SendOtpResponse> response =
            await _authDataSource.sendOtp(sendOtpRequest);
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
  Future<Result<AppErrors, EmptyEntity>> verfiyOtp(
      VerfiyOtpRequest verfiyOtpRequest) async {
    Result<AppErrors, EmptyEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, EmptyResponse> response =
            await _authDataSource.verfiyOtp(verfiyOtpRequest);
        log("Response: $response");
        result = response.fold((error) {
          log("Error1: $error");
          return Result(error: error);
        }, (response) {
          log("Response1: $response");
          return Result(data: response.toEntity());
        });
      } catch (error) {
        log("Error2: $error");
        result = Result(error: const AppErrors.responseError());
      }
    } else {
      log("No internet connection");
      result = Result(error: const AppErrors.connectionError());
    }
    return result;
  }

  @override
  Future<Result<AppErrors, EmptyEntity>> registerAsSeller(
      {required RegisterAsSellerRequest registerRequest}) async {
    Result<AppErrors, EmptyEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, EmptyResponse> response = await _authDataSource
            .registerAsSeller(registerRequest: registerRequest);
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
  Future<Result<AppErrors, EmptyEntity>> sellerInfo(
      {required SellerInfoRequest sellerInfoRequest}) async {
    Result<AppErrors, EmptyEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, EmptyResponse> response = await _authDataSource
            .sellerInfo(sellerInfoRequest: sellerInfoRequest);
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
  Future<Result<AppErrors, EmptyEntity>> sendWatsAppOtp() async {
    Result<AppErrors, EmptyEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, EmptyResponse> response =
            await _authDataSource.sendWatsAppOtp();
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
  Future<Result<AppErrors, EmptyEntity>> verfiyWatsAppOtp(
      VerfiyOtpRequest verfiyOtpRequest) async {
    Result<AppErrors, EmptyEntity> result;
    if (await _networkInfo.isConnected) {
      try {
        Either<AppErrors, EmptyResponse> response =
            await _authDataSource.verfiyWatsAppOtp(verfiyOtpRequest);
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

  // @override
  // Future<Result<AppErrors, UserInfoEntity>> getUserInfo() async {
  //   Result<AppErrors, UserInfoEntity> result;
  //   if (await _networkInfo.isConnected) {
  //     try {
  //       Either<AppErrors, UserInfoResponse> response =
  //           await _authDataSource.getUserInfo();
  //       result = response.fold((error) {
  //         return Result(error: error);
  //       }, (response) {
  //         return Result(data: response.toEntity());
  //       });
  //     } catch (error) {
  //       result = Result(error: const AppErrors.responseError());
  //     }
  //   } else {
  //     result = Result(error: const AppErrors.connectionError());
  //   }
  //   return result;
  // }
}
