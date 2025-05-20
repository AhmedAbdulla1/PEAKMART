import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:peakmart/app/app_prefs.dart' show AppPreferences;
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/constants/enums/http_method.dart';
import 'package:peakmart/core/data_source/remote_data_source.dart';
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/net/api_url.dart';
import 'package:peakmart/core/net/response_validators/default_response_validator.dart';
import 'package:peakmart/core/responses/emty_response.dart';
import 'package:peakmart/features/products/data/models/request/bid_request.dart';
import 'package:peakmart/features/products/data/models/request/enroll_request.dart';
import 'package:peakmart/features/products/data/models/request/pagination_request.dart';
import 'package:peakmart/features/products/data/models/response/products_response.dart';
import 'package:peakmart/features/products/data/models/response/top_bidders_response.dart';

class ProductsDataSource extends RemoteDataSource {
  Future<Either<AppErrors, ProductsResponse>> getProducts(
      PaginationRequest getProductsPaginationRequest) async {
    return request<ProductsResponse>(
        method: HttpMethod.GET,
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
        method: HttpMethod.GET,
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

  Future<Either<AppErrors, ProductsResponse>> getProductsByCategory(
      int catId, PaginationRequest getProductsPaginationRequest) async {
    return request<ProductsResponse>(
        method: HttpMethod.GET,
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
        method: HttpMethod.GET,
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
        method: HttpMethod.POST,
        body: enrollRequest.toJson(),
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return EmptyResponse.fromJson(json);
        },
        url: APIUrls.enrollProduct);
  }

  Future<Either<AppErrors, EmptyResponse>> bid(BidRequest bidRequest) async {
    AppPreferences appPreferences = instance<AppPreferences>();
    String userId = appPreferences.getUserId();
    log("userId is $userId");
    bidRequest.printRequest();
    return request<EmptyResponse>(
        method: HttpMethod.POST,
        body: bidRequest.toJson(),
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return EmptyResponse.fromJson(json);
        },
        url: APIUrls.bidProduct);
  }
}
