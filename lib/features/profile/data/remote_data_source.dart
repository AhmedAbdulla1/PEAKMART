import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/constants/enums/http_method.dart';
import 'package:peakmart/core/data_source/remote_data_source.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/net/api_url.dart';
import 'package:peakmart/core/net/response_validators/default_response_validator.dart';
import 'package:peakmart/core/responses/emty_response.dart';
import 'package:peakmart/features/profile/data/models/request/cancle_user_product_request.dart';
import 'package:peakmart/features/profile/data/models/request/update_profile_image_request.dart';
import 'package:peakmart/features/profile/data/models/request/update_profile_request.dart';
import 'package:peakmart/features/profile/data/models/response/user_info_response.dart';
import 'package:peakmart/features/profile/data/models/response/user_product_response.dart';
import 'package:peakmart/features/profile/data/models/response/user_products_enrolled_response.dart';

class ProfileDataSource extends RemoteDataSource {
  Future<Either<AppErrors, UserProductResponse>> getProductsUploaded() async {
    final AppPreferences appPreferences = instance<AppPreferences>();
    String cookieString = appPreferences.getCookies().join(';');
    print('cookie string $cookieString');
    return request<UserProductResponse>(
        method: HttpMethod.GET,
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return UserProductResponse.fromJson(json);
        },
        body: {
          "HK": appPreferences.getUserId(),
        },
        headers: {"cookie": cookieString},
        url: APIUrls.getProductsUploaded);
  }
  Future<Either<AppErrors, UserProductResponse>> getWishlistProducts() async {
    final AppPreferences appPreferences = instance<AppPreferences>();
    String cookieString = appPreferences.getCookies().join(';');
    return request<UserProductResponse>(
        method: HttpMethod.GET,
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return UserProductResponse.fromJson(json);
        },
        queryParameters: {
          'uid':appPreferences.getUserId()
        },
        headers: {"cookie": cookieString},
        url: APIUrls.getProductsWishlist);
  }
  Future<Either<AppErrors, UserProductsEnrolledResponse>>
      getProductsEnrolled() async {
    final AppPreferences appPreferences = instance<AppPreferences>();
    String cookieString = appPreferences.getCookies().join(';');
    print('cookie string $cookieString');
    return request<UserProductsEnrolledResponse>(
        method: HttpMethod.GET,
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return UserProductsEnrolledResponse.fromJson(json);
        },
        body: {
          "HK": appPreferences.getUserId(),
        },
        headers: {"cookie": cookieString},
        url: APIUrls.getProductsEnrolled);
  }

  Future<Either<AppErrors, EmptyResponse>> cancelUserProducts(
      CancelUserProductRequest cancleRequest) async {
    final AppPreferences appPreferences = instance<AppPreferences>();
    String userId = appPreferences.getUserId();
    String cookieString = appPreferences.getCookies().join(';');

    return request<EmptyResponse>(
      method: HttpMethod.POST,
      body: {
        ...cancleRequest.toJson(),
        "hkh": appPreferences.getCookie("HKH"),
        "hk": appPreferences.getUserId(),
        "uid": userId,
      },
      headers: {"cookie": cookieString},
      responseValidator: DefaultResponseValidator(),
      converter: (json) {
        return EmptyResponse.fromJson(json);
      },
      url: APIUrls.cancelUserProduct,
      
    );
  }

  Future<Either<AppErrors, UserInfoResponse>> getUserInfo() async {
    final AppPreferences appPreferences = instance<AppPreferences>();
    String cookieString = appPreferences.getCookies().join(';');
    print('hk ${appPreferences.getUserId()}');
    print('cookie string $cookieString');
    return request<UserInfoResponse>(
        method: HttpMethod.GET,
        body: {
          "HK": appPreferences.getUserId(),
        },
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return UserInfoResponse.fromJson(json);
        },
        headers: {"cookie": cookieString},
        url: APIUrls.getUserInfo);
  }

  Future<Either<AppErrors, EmptyResponse>> updateProfile(
      UpdateProfileRequest updateProfileRequest) async {
    final AppPreferences appPreferences = instance<AppPreferences>();
    String cookieString = appPreferences.getCookies().join(';');
    print('cookie string $cookieString');
    log("hkh: ${appPreferences.getCookie("HKH")}");
    final body = {
      ...updateProfileRequest.toMap(),
      "hk": appPreferences.getUserId(),
      "hkh": appPreferences.getCookie("HKH")
    };
    log("Body : $body");
    return request<EmptyResponse>(
      method: HttpMethod.POST,
      body: {
        ...updateProfileRequest.toMap(),
        "hk": appPreferences.getUserId(),
        "hkh": appPreferences.getCookie("HKH")
      },
      responseValidator: DefaultResponseValidator(),
      converter: (json) {
        print('inconverter $json');
        return EmptyResponse.fromJson(json);
      },
      headers: {"cookie": cookieString},
      isFormData: true,
      url: APIUrls.updateUserInfo,
    );
  }

  Future<Either<AppErrors, EmptyResponse>> updaterProfileImage(
      UpdateProfileImageRequest body) async {
    final AppPreferences appPreferences = instance<AppPreferences>();
    String cookieString = appPreferences.getCookies().join(';');
    print('cookie string $cookieString');
    return request<EmptyResponse>(
      method: HttpMethod.POST,
      body: body.toMap(),
      files: body.getFiles(),
      responseValidator: DefaultResponseValidator(),
      converter: (json) {
        print('inconverter $json');
        return EmptyResponse.fromJson(json);
      },
      headers: {
        'Content-Type': 'multipart/form-data',
        "cookie": cookieString,
      },
      isFormData: true,
      url: APIUrls.updateUserImage,
    );
  }
  Future<Either<AppErrors, EmptyResponse>> logout() async {
    final AppPreferences appPreferences = instance<AppPreferences>();
    String cookieString = appPreferences.getCookies().join(';');
    cookieString +="HK=290;" ;
    print('cookie string $cookieString');
    return request<EmptyResponse>(
      method: HttpMethod.GET,
      responseValidator: DefaultResponseValidator(),
      converter: (json) {
        print('inconverter $json');
        return EmptyResponse.fromJson(json);
      },
      headers: {"cookie": cookieString},
      url: APIUrls.logout,
    );
  }
}
