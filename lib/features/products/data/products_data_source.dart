import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:peakmart/core/constants/enums/http_method.dart';
import 'package:peakmart/core/data_source/remote_data_source.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/net/api_url.dart';
import 'package:peakmart/core/net/response_validators/default_response_validator.dart';
import 'package:peakmart/features/products/data/models/response/products_response.dart';

class ProductsDataSource extends RemoteDataSource {
  Future<Either<AppErrors, ProductsResponse>> getProducts() async {
    return request<ProductsResponse>(
        method: HttpMethod.GET,
        queryParameters: {"limit": 5},
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          log("message done in getBidWorkNow request");
          log("json is $json");
          return ProductsResponse.fromJson(json);
        },
        url: APIUrls.getBidWorkNow);
  }

  Future<Either<AppErrors, ProductsResponse>> getProductsByCategory(
      int catId) async {
    return request<ProductsResponse>(
        method: HttpMethod.GET,
        queryParameters: {"id": catId},
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          log("message done in ended bids request");
          return ProductsResponse.fromJson(json);
        },
        url: APIUrls.getProductsByCategory);
  }
}
