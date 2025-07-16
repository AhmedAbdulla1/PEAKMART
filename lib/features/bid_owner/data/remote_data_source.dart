import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:Bid_Mart/app/app_prefs.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/constants/enums/http_method.dart';
import 'package:Bid_Mart/core/data_source/remote_data_source.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/net/api_url.dart';
import 'package:Bid_Mart/core/net/response_validators/default_response_validator.dart';
import 'package:Bid_Mart/core/net/response_validators/response_validator.dart';
import 'package:Bid_Mart/core/responses/emty_response.dart';
import 'package:Bid_Mart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:Bid_Mart/features/bid_owner/data/models/response/check_is_seller_response.dart';
import 'package:Bid_Mart/features/home/data/model/response/category_response.dart';
import 'package:flutter/material.dart';

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
  Future<Either<AppErrors, EmptyResponse>> addProduct(
      AddProductRequest body) async {
    final AppPreferences appPreferences = instance<AppPreferences>();
    String cookieString = appPreferences.getCookies().join(';');
    debugPrint('cookie string $cookieString');
    debugPrint('body ${body.toJson()}');
    return request<EmptyResponse>(
      method: HttpMethod.post,
      body: body.toJson(),
      files: body.getFiles(),
      responseValidator: AddProductValidator(),
      converter: (json) {
        return EmptyResponse.fromJson(json);
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
      method: HttpMethod.get,
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
        method: HttpMethod.get,
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
