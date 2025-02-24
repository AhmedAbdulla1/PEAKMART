import 'package:dartz/dartz.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/constants/enums/http_method.dart';
import 'package:peakmart/core/data_source/remote_data_source.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/net/api_url.dart';
import 'package:peakmart/core/net/response_validators/default_response_validator.dart';
import 'package:peakmart/core/responses/emty_response.dart';
import 'package:peakmart/features/auth/data/model/request/login_request.dart';
import 'package:peakmart/features/auth/data/model/request/register_request.dart';
import 'package:peakmart/features/auth/data/model/request/rest_password_request.dart';
import 'package:peakmart/features/auth/data/model/request/seller_info_request.dart';
import 'package:peakmart/features/auth/data/model/request/send_otp_request.dart';
import 'package:peakmart/features/auth/data/model/request/signup_for_bid_request.dart';
import 'package:peakmart/features/auth/data/model/request/verfiy_otp_request.dart';
import 'package:peakmart/features/auth/data/model/response/login_response.dart';
import 'package:peakmart/features/auth/data/model/response/register_response.dart';
import 'package:peakmart/features/auth/data/model/response/send_otp_response.dart';

class AuthDataSource extends RemoteDataSource {
  Future<Either<AppErrors, LoginResponse>> login(
      LoginRequest loginRequest) async {
    return request<LoginResponse>(
      method: HttpMethod.POST,
      body: loginRequest.toJson(),
      responseValidator: DefaultResponseValidator(),
      converter: (json) {
        return LoginResponse.fromJson(json);
      },
      url: APIUrls.login,
      saveCookies: true,
    );
  }

  Future<Either<AppErrors, EmptyResponse>> restPassword(
      RestPasswordRequest resetPassword) async {
    return request<EmptyResponse>(
        method: HttpMethod.POST,
        body: resetPassword.toJson(),
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return EmptyResponse.fromJson(json);
        },
        url: APIUrls.resetPassword);
  }

  Future<Either<AppErrors, RegisterResponse>> register(
      RegisterRequest registerRequest) async {
    return request<RegisterResponse>(
      method: HttpMethod.POST,
      body: registerRequest.toJson(),
      responseValidator: DefaultResponseValidator(),
      converter: (json) {
        return RegisterResponse.fromJson(json);
      },
      url: APIUrls.register,
      saveCookies: true,
    );
  }

  Future<Either<AppErrors, SendOtpResponse>> sendOtp(
      SendOtpRequest sendOtpRequest) async {
    return request<SendOtpResponse>(
        method: HttpMethod.POST,
        body: sendOtpRequest.toJson(),
        headers: sendOtpRequest.toHeaders(),
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return SendOtpResponse.fromJson(json);
        },
        url: APIUrls.sendOtp);
  }

  Future<Either<AppErrors, EmptyResponse>> verfiyOtp(
      VerfiyOtpRequest verfiyOtpRequest) async {
    return request<EmptyResponse>(
        method: HttpMethod.POST,
        body: verfiyOtpRequest.toJson(),
        headers: verfiyOtpRequest.toHeaders(),
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return EmptyResponse.fromJson(json);
        },
        url: APIUrls.verfiyOtp);
  }
  Future<Either<AppErrors, EmptyResponse>> sendWatsAppOtp() async {
    final AppPreferences appPreferences = instance<AppPreferences>();
    String cookieString = appPreferences.getCookies().join(';');
    print('cookie string $cookieString');
    return request<EmptyResponse>(
        method: HttpMethod.POST,
        headers: {"cookie": cookieString},
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return EmptyResponse.fromJson(json);
        },
        url: APIUrls.sendWatsAppOtp);
  }

  Future<Either<AppErrors, EmptyResponse>> verfiyWatsAppOtp(
      VerfiyOtpRequest verfiyOtpRequest) async {
    return request<EmptyResponse>(
        method: HttpMethod.POST,
        body: verfiyOtpRequest.toJson(),
        headers: verfiyOtpRequest.toHeaders(),
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return EmptyResponse.fromJson(json);
        },
        url: APIUrls.verfiyWatsAppOtp);
  }

  Future<Either<AppErrors, EmptyResponse>> registerAsSeller(
      {required RegisterAsSellerRequest registerRequest}) async {
    final AppPreferences appPreferences = instance<AppPreferences>();
    String cookieString = appPreferences.getCookies().join(';');
    print('cookie string $cookieString');
    return request<EmptyResponse>(
      method: HttpMethod.POST,
      body: registerRequest.toJson(),
      responseValidator: DefaultResponseValidator(),
      converter: (json) {
        return EmptyResponse.fromJson(json);
      },
      headers: {"cookie": cookieString},
      url: APIUrls.registerAsSeller,
      saveCookies: true,
    );
  }

  Future<Either<AppErrors, EmptyResponse>> sellerInfo(
      {required SellerInfoRequest sellerInfoRequest}) async {
    final AppPreferences appPreferences = instance<AppPreferences>();
    String cookieString = appPreferences.getCookies().join(';');
    print('cookie string $cookieString');
    return request<EmptyResponse>(
      method: HttpMethod.POST,
      body: sellerInfoRequest.toJson(),
      responseValidator: DefaultResponseValidator(),
      converter: (json) {
        return EmptyResponse.fromJson(json);
      },
      files: sellerInfoRequest.getFiles(),
      headers: {"cookie": cookieString},
      url: APIUrls.addSellerInfo,
      isFormData: true,
      saveCookies: true,
    );
  }
}
