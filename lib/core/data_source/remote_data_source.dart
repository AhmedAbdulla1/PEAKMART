import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:peakmart/core/constants/enums/http_method.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/core/net/create_model_interceptor/create_model.interceptor.dart';
import 'package:peakmart/core/net/create_model_interceptor/default_create_model_inteceptor.dart';
import 'package:peakmart/core/net/http_client.dart';
import 'package:peakmart/core/net/models_factory.dart';
import 'package:peakmart/core/net/response_validators/default_response_validator.dart';
import 'package:peakmart/core/net/response_validators/list_response_validator.dart';
import 'package:peakmart/core/net/response_validators/response_validator.dart';
import 'package:peakmart/features/auth/data/model/response/login_response.dart';

class RemoteDataSource {
  Future<Either<AppErrors, T>> requestUploadFile<T extends BaseResponse>({
    required T Function(dynamic json) converter,
    required String url,
    required String fileKey,
    required String filePath,
    required MediaType mediaType,
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool withAuthentication = false,
    bool withTenants = false,
    CancelToken? cancelToken,
    ResponseValidator? responseValidator,
    Map<String, String>? headers,
    String? baseUrl,
    CreateModelInterceptor createModelInterceptor =
        const DefaultCreateModelInterceptor(),
  }) async {
    // Register the response.
    ModelsFactory()
      ..registerModel(
        T.toString(),
        converter,
        createModelInterceptor.toString(),
        createModelInterceptor,
      );
    // late final httpClient;
    // if (httpClientType == HttpClientType.MAIN) httpClient = getIt<HttpClient>();
    // else if(httpClientType == HttpClientType.SPOTIFY) httpClient = getIt<SpotifyHttpClient>();
    // else{
    //   httpClient = getIt<HttpClient>();
    // }

    /// Send the request.
    final response = await HttpClient().upload<T>(
      url: url,
      fileKey: fileKey,
      filePath: filePath,
      fileName: filePath.substring(filePath.lastIndexOf('/') + 1),
      mediaType: mediaType,
      data: data!,
      headers: headers,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
      responseValidator: responseValidator ?? DefaultResponseValidator(),
      baseUrl: baseUrl,
    );

    /// convert jsonResponse to model and return it
    if (response.isLeft()) {
      return Left((response as Left<AppErrors, T>).value);
    } else if (response.isRight()) {
      try {
        final resValue = (response as Right<AppErrors, T>).value;
        return Right(resValue);
      } catch (e) {
        return const Left(
            CustomError(message: "Catch error in remote data source"));
      }
    } else
      return const Left(UnknownError());
  }

  Future<Either<AppErrors, T>> request<T extends BaseResponse>({
    required T Function(dynamic json) converter,
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    bool withAuthentication = false,
    CancelToken? cancelToken,
    ResponseValidator? responseValidator,
    Map<String, String>? headers,
    String? baseUrl,
    bool isFormData = false,
    CreateModelInterceptor createModelInterceptor =
        const DefaultCreateModelInterceptor(),
  }) async {
    // Register the response.
    ModelsFactory()
      ..registerModel(
        T.toString(),
        converter,
        createModelInterceptor.toString(),
        createModelInterceptor,
      );

    print('url for request $url');

    /// Send the request.
    final response = await HttpClient().sendRequest<T>(
      method: method,
      url: url,
      headers: headers,
      queryParameters: queryParameters ?? Map<String, dynamic>(),
      body: body,
      cancelToken: cancelToken,
      responseValidator: responseValidator ?? DefaultResponseValidator(),
      baseUrl: baseUrl,
    );

    /// convert jsonResponse to model and return it
    if (response.isLeft()) {
      return Left((response as Left<AppErrors, T>).value);
    } else if (response.isRight()) {
      try {
        final resValue = (response as Right<AppErrors, T>).value;
        return Right(resValue);
      } catch (e) {
        return const Left(
            CustomError(message: "Catch error in remote data source"));
      }
    } else {
      return const Left(UnknownError());
    }
  }

  Future<Either<AppErrors, List<T>>> listRequest<T extends BaseResponse>({
    required T Function(dynamic json) converter,
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    bool withAuthentication = false,
    CancelToken? cancelToken,
    ResponseValidator? responseValidator,
    Map<String, String>? headers,
    String? baseUrl,
    CreateModelInterceptor createModelInterceptor =
        const DefaultCreateModelInterceptor(),
  }) async {
    // Register the response.
    ModelsFactory()
      ..registerModel(
        T.toString(),
        converter,
        createModelInterceptor.toString(),
        createModelInterceptor,
      );

    /// Send the request.
    final response = await HttpClient().sendListRequest<T>(
      method: method,
      url: url,
      headers: headers,
      queryParameters: queryParameters ?? Map<String, dynamic>(),
      body: body,
      cancelToken: cancelToken,
      responseValidator: responseValidator ?? ListResponseValidator(),
      baseUrl: baseUrl,
    );

    /// convert jsonResponse to model and return it
    if (response.isLeft()) {
      return Left((response as Left<AppErrors, List<T>>).value);
    } else if (response.isRight()) {
      try {
        final resValue = (response as Right<AppErrors, List<T>>).value;
        return Right(resValue);
      } catch (e) {
        return const Left(
            CustomError(message: "Catch error in remote data source"));
      }
    } else
      return const Left(UnknownError());
  }
}
