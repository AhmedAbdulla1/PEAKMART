import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:Bid_Mart/app/app_prefs.dart' show AppPreferences;
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/constants/enums/http_method.dart';
import 'package:Bid_Mart/core/data_source/remote_data_source.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/net/api_url.dart';
import 'package:Bid_Mart/core/net/response_validators/default_response_validator.dart';
import 'package:Bid_Mart/core/net/response_validators/response_validator.dart';
import 'package:Bid_Mart/core/responses/emty_response.dart';
import 'package:Bid_Mart/features/products/data/models/request/bid_request.dart';
import 'package:Bid_Mart/features/products/data/models/request/enroll_request.dart';
import 'package:Bid_Mart/features/products/data/models/request/pagination_request.dart';
import 'package:Bid_Mart/features/products/data/models/response/products_response.dart';
import 'package:Bid_Mart/features/products/data/models/response/top_bidders_response.dart';
import 'package:flutter/material.dart';

import 'models/response/check_wishlist_response.dart'
    show CheckWishlistResponse;

class ProductsDataSource extends RemoteDataSource {
  Future<Either<AppErrors, ProductsResponse>> getProducts(
      PaginationRequest getProductsPaginationRequest) async {
    return request<ProductsResponse>(
        method:  HttpMethod.get,
        queryParameters: getProductsPaginationRequest.toJson(),
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          log("json is $json");
          return ProductsResponse.fromJson(json);
        },
        url: APIUrls.getProducts);
  }

  Future<Either<AppErrors, ProductsResponse>> getProductById(
      int productId) async {
    return request<ProductsResponse>(
        method:  HttpMethod.get,
        queryParameters: {
          "id": productId,
          "userId": instance<AppPreferences>().getUserId(),
        },
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return ProductsResponse.fromJson(json);
        },
        url: APIUrls.getProductById);
  }

  Future<Either<AppErrors, CheckWishlistResponse>> checkProductInWishlist(
      int productId) async {
    return request<CheckWishlistResponse>(
        method:  HttpMethod.get,
        queryParameters: {
          "pid": productId,
          "uid": instance<AppPreferences>().getUserId(),
        },
        responseValidator: CheckWishlistValidator(),
        converter: (json) {
          debugPrint('json check in wich list');
          return CheckWishlistResponse.fromJson(json);
        },
        url: APIUrls.checkInWishlist);
  }

  Future<Either<AppErrors, EmptyResponse>> addProductInWishlist(
      int productId) async {
    return request<EmptyResponse>(
        method:  HttpMethod.get,
        queryParameters: {
          "pid": productId,
          "uid": instance<AppPreferences>().getUserId(),
        },
        responseValidator: CheckWishlistValidator(),
        converter: (json) {
          debugPrint('json check in wich list');
          return EmptyResponse.fromJson(json);
        },
        url: APIUrls.addToWishlist);
  }

  Future<Either<AppErrors, EmptyResponse>> removeProductFromWishlist(
      int productId) async {
    return request<EmptyResponse>(
        method:  HttpMethod.get,
        queryParameters: {
          "pid": productId,
          "uid": instance<AppPreferences>().getUserId(),
        },
        responseValidator: CheckWishlistValidator(),
        converter: (json) {
          debugPrint('json check in wich list');
          return EmptyResponse.fromJson(json);
        },
        url: APIUrls.removeFromWishlist);
  }

  Future<Either<AppErrors, ProductsResponse>> getProductsByCategory(
      int catId, PaginationRequest getProductsPaginationRequest) async {
    return request<ProductsResponse>(
        method:  HttpMethod.get,
        queryParameters: {
          "id": catId,
          ...getProductsPaginationRequest.toJson(),
        },
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return ProductsResponse.fromJson(json);
        },
        url: APIUrls.getProducts);
  }

  Future<Either<AppErrors, TopBiddersResponse>> getTopBidders(
      int productId) async {
    AppPreferences appPreferences = instance<AppPreferences>();
    String userId = appPreferences.getUserId();
    log("userId is $userId");
    return request<TopBiddersResponse>(
        method:  HttpMethod.get,
        queryParameters: {"id": productId, "uid": userId},
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return TopBiddersResponse.fromJson(json);
        },
        url: APIUrls.getTopBidders);
  }

  Future<Either<AppErrors, EmptyResponse>> enroll(
      EnrollRequest enrollRequest) async {
    AppPreferences appPreferences = instance<AppPreferences>();
    String userId = appPreferences.getUserId();
    log("userId is $userId");
    enrollRequest.printRequest();
    return request<EmptyResponse>(
        method:  HttpMethod.post,
        body: enrollRequest.toJson(),
        responseValidator: EnrollValidator(),
        converter: (json) {
          return EmptyResponse.fromJson(json);
        },
        url: APIUrls.enrollProduct);
  }

  Future<Either<AppErrors, EmptyResponse>> bid(BidRequest bidRequest) async {
    bidRequest.printRequest();
    return request<EmptyResponse>(
        method:  HttpMethod.post,
        body: bidRequest.toJson(),
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          log('json is $json', name: "bid response");
          return EmptyResponse.fromJson(json);
        },
        url: APIUrls.bidProduct);
  }
}

class EnrollValidator extends ResponseValidator {
  @override
  void processData(data) {
    if (data["enrollment_id"] == null) {
      errorMessage = data["message"] ?? "";
    }
  }
}

class CheckWishlistValidator extends ResponseValidator {
  @override
  void processData(data) {
    if (data["error"] != null) {
      errorMessage = data["error"] ?? "";
    }
  }
}
