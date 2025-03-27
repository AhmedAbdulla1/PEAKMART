import 'package:dartz/dartz.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/constants/enums/http_method.dart';
import 'package:peakmart/core/data_source/remote_data_source.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/net/api_url.dart';
import 'package:peakmart/core/net/response_validators/default_response_validator.dart';
import 'package:peakmart/core/responses/emty_response.dart';
import 'package:peakmart/features/profile/data/models/request/update_profile_image_request.dart';
import 'package:peakmart/features/profile/data/models/request/update_profile_request.dart';
import 'package:peakmart/features/profile/data/models/response/user_info_response.dart';
import 'package:peakmart/features/profile/data/models/response/user_product_response.dart';

class ProfileDataSource extends RemoteDataSource {
  Future<Either<AppErrors, UserProductResponse>> getUserProducts() async {
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
        url: APIUrls.getUserProducts);
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
        saveCookies: true,
        headers: {"cookie": cookieString},
        url: APIUrls.getUserInfo);
  }

  Future<Either<AppErrors, EmptyResponse>> updateProfile(
      UpdateProfileRequest updateProfileRequest) async {
    final AppPreferences appPreferences = instance<AppPreferences>();
    String cookieString = appPreferences.getCookies().join(';');
    print('cookie string $cookieString');
    return request<EmptyResponse>(
      method: HttpMethod.POST,
      body: updateProfileRequest.toMap(),
      responseValidator: DefaultResponseValidator(),
      converter: (json) {
        return EmptyResponse.fromJson(json);
      },
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
      files: body.getFiles(),
      responseValidator: DefaultResponseValidator(),
      converter: (json) {
        return EmptyResponse.fromJson(json);
      },
      headers: {"cookie": cookieString},
      url: APIUrls.updateUserInfo,
    );
  }
}
