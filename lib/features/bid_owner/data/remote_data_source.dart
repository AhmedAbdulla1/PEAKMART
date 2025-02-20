import 'package:dartz/dartz.dart';
import 'package:peakmart/core/constants/enums/http_method.dart';
import 'package:peakmart/core/data_source/remote_data_source.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/net/api_url.dart';
import 'package:peakmart/core/net/response_validators/default_response_validator.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:peakmart/features/bid_owner/data/models/response/add_product_response.dart';

class OwnerDataSource extends RemoteDataSource {
  Future<Either<AppErrors, AddProductResponse>> addProduct(
      AddProductRequest addProductRequest) async {
    return request<AddProductResponse>(
        method: HttpMethod.POST,
        body: addProductRequest.toJson(),
        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return AddProductResponse.fromJson(json);
        },
        url: APIUrls.addProduct);
  }
}
