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

class OwnerDataSource extends RemoteDataSource {
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
        return const Left(
            const AppErrors.responseError(message: "Failed to add product"));
      }
    } catch (e, stacktrace) {
      print("Unexpected Error: $e");
      print(stacktrace);
      return const Left(
          const AppErrors.responseError(message: "Unexpected error occurred"));
    }
  }

  Future<Either<AppErrors,CheckIsSellerResponse>> checkIsASeller() async {
    AppPreferences appPref = instance<AppPreferences>();
    print(appPref.getUserId());
    return request<CheckIsSellerResponse>(
      method: HttpMethod.GET,
      queryParameters: {
        "userId ": appPref.getUserId(),
      },
      responseValidator: CheckIsASellerValidator(),
      converter: (json) {
        return CheckIsSellerResponse.fromJson(json);
      },
      headers: {"cookie": appPref.getCookies().join(';') },
      url: APIUrls.checkIsASeller,
    );
  }
}

class CheckIsASellerValidator extends ResponseValidator {


  @override
  void processData(data) {
      if(data["error"] != null) {
        error = AppErrors.customError(message: data["error"]);
        errorMessage = data["error"];
      }
  }
}
