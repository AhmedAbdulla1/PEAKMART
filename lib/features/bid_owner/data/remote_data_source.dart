import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/net/api_url.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:peakmart/features/bid_owner/data/models/response/add_product_response.dart';

class OwnerDataSource {
  final Dio _dio = Dio();

  Future<Either<AppErrors, AddProductResponse>> addProduct(
      AddProductRequest addProductRequest) async {
    try {
      FormData formData = await addProductRequest.toFormData();

      Response response = await _dio.post(
        APIUrls.addProduct,
        data: formData,
        options: Options(
          headers: {"Content-Type": "multipart/form-data"},
        ),
      );

      print("Raw API Response: ${response.data}");

      if (response.statusCode == 200) {
        return Right(AddProductResponse.fromJson(response.data));
      } else {
        return const Left(const AppErrors.responseError(message: "Failed to add product"));
      }
    } catch (e, stacktrace) {
      print("Unexpected Error: $e");
      print(stacktrace);
      return const Left(const AppErrors.responseError(message: "Unexpected error occurred"));
    }
  }
}
