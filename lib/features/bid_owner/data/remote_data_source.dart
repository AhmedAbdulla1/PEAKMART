import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/constants/enums/http_method.dart';
import 'package:peakmart/core/data_source/remote_data_source.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/net/api_url.dart';
import 'package:peakmart/core/net/response_validators/default_response_validator.dart';
import 'package:peakmart/core/net/response_validators/response_validator.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:peakmart/features/bid_owner/data/models/response/add_product_response.dart';
import 'package:peakmart/features/bid_owner/data/models/response/check_is_seller_response.dart';
import 'package:peakmart/features/home/data/model/response/category_response.dart';

class AddProductValidator extends ResponseValidator {
  @override
  void processData(data) {
    if (!(data["status"] =="success")) {
      error = AppErrors.customError(message: data["errors"][0]?? "");
      errorMessage = data["errors"][0]?? "";
    }
  }
}

class OwnerDataSource extends RemoteDataSource {
  Future<Either<AppErrors, AddProductResponse>> addProduct(
      AddProductRequest body) async {
    final AppPreferences appPreferences = instance<AppPreferences>();
    String cookieString = appPreferences.getCookies().join(';');
    print('cookie string $cookieString');
    print('body ${body.toJson()}');
    return request<AddProductResponse>(
      method: HttpMethod.POST,
      body: body.toJson(),
      files: body.getFiles(),
      responseValidator: AddProductValidator(),
      converter: (json) {
        print('inconverter $json');
        return AddProductResponse.fromJson(json);
      },
      headers: {
        'Content-Type': 'multipart/form-data',
        "cookie": cookieString,
      },
      isFormData: true,
      url: APIUrls.addProduct,
    );
  }

  Future<Either<AppErrors, CheckIsSellerResponse>> checkIsASeller() async {
    AppPreferences appPref = instance<AppPreferences>();
    log(appPref.getUserId());
    return request<CheckIsSellerResponse>(
      method: HttpMethod.GET,
      queryParameters: {
        "userId": appPref.getUserId(),
      },
      responseValidator: CheckIsASellerValidator(),
      converter: (json) {
        return CheckIsSellerResponse.fromJson(json);
      },
      headers: {"cookie": appPref.getCookies().join(';')},
      url: APIUrls.checkIsASeller,
    );
  }

  Future<Either<AppErrors, CategoriesResponse>> getCategories() async {
    return request<CategoriesResponse>(
        method: HttpMethod.GET,
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          log("message done in Trending bids request");
          return CategoriesResponse.fromJson(json);
        },
        url: APIUrls.getCategories);
  }
}

class CheckIsASellerValidator extends ResponseValidator {
  @override
  void processData(data) {
    if (data["error"] != null) {
      error = AppErrors.customError(message: data["error"]);
      errorMessage = data["error"];
    }
  }
}
