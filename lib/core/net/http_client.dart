import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:peakmart/app/app_config.dart';
import 'package:peakmart/core/constants/app/app_constants.dart';
import 'package:peakmart/core/constants/enums/http_method.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/core/net/response_validators/response_validator.dart';

import 'api_url.dart';
import 'base_http_client.dart';
import 'models_factory.dart';

@lazySingleton
class HttpClient extends BaseHttpClient {
  late Dio _client;

  Dio get instance => _client;

  HttpClient() {
    BaseOptions _options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
      sendTimeout: const Duration(milliseconds: 100000),
      responseType: ResponseType.json,
      baseUrl: APIUrls.baseUrl,
    );
    _client = Dio(_options);

    /// for alice inspector
    // _client.interceptors
    //     .add(getIt<AliceHttpInspector>().alice.getDioInterceptor());

    /// For logger
    // if (AppConfig().appOptions.enableDioPrinting) {
    //   _client.interceptors.add(PrettyDioLogger());
    // }

    /// For add Authentication into header
    /// [authorization] [os] [appversion] [session]
    // _client.interceptors.add(AuthInterceptor());

    _client.interceptors.add(InterceptorsWrapper(
        // onRequest: (options, handler) async{
        //   if (await AppConfig().hasToken) {
        //   final token = await AppConfig().authToken;
        //   final os = AppConfig().os;
        //   final appVersion = AppConfig().appVersion;
        //   if (os != null) options.headers[AppConstants.HEADER_OS] = '$os';
        //   if (appVersion != null)
        //   options.headers[AppConstants.HEADER_APP_VERSION] = '$appVersion';
        //   if (os != null) options.headers[AppConstants.HEADER_AUTH] = '$token';
        //   if (appVersion != null)
        //   options.headers[AppConstants.HEADER_APP_VERSION] = '$appVersion';
        //   if (os != null) options.headers[AppConstants.HEADER_AUTH] = '$token';
        //   // options.headers[AppConstants.HEADER_AUTH] = '$apiKey';
        //   options.headers[AppConstants.HEADER_AUTH] = '$token';
        //   // options.headers[AppConstants.HEADER_LANGUAGE] = Intl.getCurrentLocale();
        //   }
        //   options.queryParameters[AppConstants.QUERY_PARAM_LANGUAGE] = Intl.getCurrentLocale();
        //
        //   handler.next(options);
        // },
        onResponse: (response, handler) {
      print("Future<void> onResponse${response.requestOptions.path}");
      try {
        final int? statusCode = response.statusCode;
        switch (statusCode) {
          case 200:
            handler.next(response);
            break;
          case 401:
            break;
          case 500:
            // if(APIUrls.API_CHECK_COUPON_VALIDITY != response.requestOptions.path)
            // print(response.requestOptions.path);
            handler.next(response);
            break;
          default:
            handler.next(response);
            return;
        }
      } catch (ex) {
        handler.reject(
          DioError(
              requestOptions: response.requestOptions,
              response: response,
              error: ex),
          true,
        );
      }
    }, onError: (error, h) async {
      if (error.response?.statusCode == 403 ||
          error.response?.statusCode == 401) {
        // return _retry(error.request);
      }
      if (error.response?.statusCode == 500) {
        // if(APIUrls.API_CHECK_COUPON_VALIDITY != error.requestOptions.path)
        //   print(error.requestOptions.path);
        h.next(error);
      } else {
        h.next(error);
      }
    }));
  }

  Future<Either<AppErrors, T>> sendRequest<T extends BaseResponse>({
    required HttpMethod method,
    required String url,
    required ResponseValidator responseValidator,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    CancelToken? cancelToken,
    String? baseUrl,
    bool isFormData = false,
  }) async {
    if (baseUrl != null) {
      _client.options.baseUrl = baseUrl;
    } else {
      _client.options.baseUrl = APIUrls.baseUrl;
    }
    // Get the response from the server
    Response response;
    try {
      switch (method) {
        case HttpMethod.GET:
          response = await _client.get(
            url,
            queryParameters: queryParameters,
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.POST:
          response = await _client.post(
            url,
            data: isFormData && body != null ? FormData.fromMap(body) : body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.PUT:
          response = await _client.put(
            url,
            data: isFormData && body != null ? FormData.fromMap(body) : body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.DELETE:
          response = await _client.delete(
            url,
            data: isFormData && body != null ? FormData.fromMap(body) : body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
      }
      // Get the decoded json
      /// json response like this
      /// {"data":"our data",
      /// "succeed":true of false,
      /// "message":"message if there is error"}
      /// response.data["succeed"] return true if request
      /// succeed and false if not so if was true we don't need
      /// return this value to model we just need the data
      var model;
      print(response.data);
      responseValidator.processData(response.data);
      if (responseValidator.isValid) {
        if (response.statusCode == 401) {}

        /// Here we send the data from response to Models factory
        /// to assign data as model
        ///
        try {
          model = ModelsFactory().createModel<T>(response.data);
        } catch (e) {
          if (response.statusCode == 401) {
            return const Left(UnauthorizedError());
          }
          return Left(CustomError(message: e.toString()));
        }
        return Right(model);
      } else if (responseValidator.hasError) {
        return Left(CustomError(message: responseValidator.errorMessage!));
      } else
        return const Left(
          CustomError(
            message: 'genral error',
          ),
        );
    }

    /// Handling errors
    on DioError catch (e) {
      return Left(_handleDioError(e));
    }

    /// Couldn't reach out the server
    on SocketException catch (e) {
      return const Left(SocketError());
    }
  }

  Future<Either<AppErrors, List<T>>> sendListRequest<T extends BaseResponse>({
    required HttpMethod method,
    required String url,
    required ResponseValidator responseValidator,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    CancelToken? cancelToken,
    String? baseUrl,
    bool isFormData = false,
  }) async {
    if (baseUrl != null) {
      _client.options.baseUrl = baseUrl;
    } else {
      _client.options.baseUrl = APIUrls.baseUrl;
    }
    // _client.interceptors.add(DioCacheInterceptor(options: CacheOptions(store: MemCacheStore(),priority:  CachePriority.high,maxStale: const Duration(days: 7),hitCacheOnErrorExcept: [401, 403], policy: CachePolicy.forceCache,)));
    // Get the response from the server
    Response response;
    try {
      switch (method) {
        case HttpMethod.GET:
          response = await _client.get(
            url,
            queryParameters: queryParameters,
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.POST:
          response = await _client.post(
            url,
            data: isFormData && body != null ? FormData.fromMap(body) : body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.PUT:
          response = await _client.put(
            url,
            data: isFormData && body != null ? FormData.fromMap(body) : body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.DELETE:
          response = await _client.delete(
            url,
            data: isFormData && body != null ? FormData.fromMap(body) : body,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
      }
      // Get the decoded json
      /// json response like this
      /// {"data":"our data",
      /// "succeed":true of false,
      /// "message":"message if there is error"}
      /// response.data["succeed"] return true if request
      /// succeed and false if not so if was true we don't need
      /// return this value to model we just need the data
      var model;
      responseValidator.processData(response.data);

      if (responseValidator.isValid) {
        if (response.statusCode == 401) {}

        /// Here we send the data from response to Models factory
        /// to assign data as model
        try {
          model = (response.data as List)
              .map((e) => ModelsFactory().createModel<T>(e))
              .toList();
        } catch (e) {
          return Left(CustomError(message: e.toString()));
        }
        return Right(model);
      } else if (responseValidator.hasError) {
        return Left(CustomError(message: responseValidator.errorMessage!));
      } else
        return const Left(
          CustomError(
            message: 'genral error',
          ),
        );
    }

    /// Handling errors
    on DioError catch (e) {
      return Left(_handleDioError(e));
    }

    /// Couldn't reach out the server
    on SocketException catch (e) {
      return const Left(SocketError());
    }
  }

  Future<Either<AppErrors, T>> upload<T extends BaseResponse>({
    required String url,
    required String fileKey,
    required String filePath,
    required String fileName,
    required MediaType mediaType,
    required CancelToken? cancelToken,
    required ResponseValidator responseValidator,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    String? baseUrl,
  }) async {
    if (baseUrl != null) {
      _client.options.baseUrl = baseUrl;
    } else {
      _client.options.baseUrl = APIUrls.baseUrl;
    }

    Map<String, dynamic> dataMap = {};
    if (data != null) {
      dataMap.addAll(data);
    }
    dataMap.addAll({
      fileKey: await MultipartFile.fromFile(
        filePath,
        filename: fileName,
        contentType: mediaType,
      )
    });
    try {
      final response = await _client.post(
        url,
        data: FormData.fromMap(dataMap),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      // Get the decoded json
      /// json response like this
      /// {"data":"our data",
      /// "succeed":true of false,
      /// "message":"message if there is error"}
      /// response.data["succeed"] return true if request
      /// succeed and false if not so if was true we don't need
      /// return this value to model we just need the data
      var model;
      responseValidator.processData(response.data);

      if (responseValidator.isValid) {
        if (response.statusCode == 401) {}

        /// Here we send the data from response to Models factory
        /// to assign data as model
        try {
          model = ModelsFactory().createModel<T>(response.data);
        } catch (e) {
          return Left(CustomError(message: e.toString()));
        }
        return Right(model);
      } else if (responseValidator.hasError) {
        return Left(CustomError(message: responseValidator.errorMessage!));
      } else
        return const Left(UnknownError());
    }
    // Handling errors
    on DioError catch (e) {
      return Left(_handleDioError(e));
    }

    // Couldn't reach out the server
    on SocketException catch (e) {
      return const Left(SocketError());
    }
  }

  Future<void> sendWithOutLayers({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    _client.options.baseUrl = APIUrls.baseUrl;
    Response response;
    try {
      switch (method) {
        case HttpMethod.GET:
          response = await _client.get(
            url,
            queryParameters: queryParameters,
          );
          break;
        case HttpMethod.POST:
          response = await _client.post(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(),
          );
          break;
        case HttpMethod.PUT:
          response = await _client.put(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(),
          );
          break;
        case HttpMethod.DELETE:
          response = await _client.delete(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(),
          );
          break;
      }
      if (response.statusCode == 200) {
      } else {
        sendWithOutLayers(
            method: method,
            url: url,
            queryParameters: queryParameters,
            body: body);
      }
    }

    /// Handling errors
    on DioException catch (e) {
      _handleDioError(e);
    }

    /// Couldn't reach out the server
    on SocketException catch (e) {}
  }

  AppErrors _handleDioError<E>(DioException error) {
    if (error.type == DioExceptionType.unknown ||
        error.type == DioExceptionType.badResponse) {
      if (error.error is SocketException) return const SocketError();
      if (error.type == DioExceptionType.badResponse) {
        switch (error.response!.statusCode) {
          case 400:
            print(error.response!.statusCode);
            return const BadRequestError();
          case 401:
            return const UnauthorizedError();
          case 403:
            return const ForbiddenError();
          case 404:
            return NotFoundError(error.requestOptions.path);
          case 409:
            return const ConflictError();
          case 500:
            if (error.response?.data is Map) {
              if (error.response!.data?["message"] != null ||
                  error.response!.data?["status_code"] != null)
                return InternalServerWithDataError(
                    int.tryParse(
                            error.response!.data?["status_code"]?.toString() ??
                                "") ??
                        500,
                    message: error.response?.data?["message"]);
            }
            return const InternalServerError();

          //   return ErrorMessageModel<E>.fromMap(error.response!.data);
          default:
            return const UnknownError();
        }
      }
      return const UnknownError();
    } else {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return const TimeoutError();
      } else if (error.type == DioExceptionType.cancel) {
        return const CancelError('cancel error');
      } else
        return const UnknownError();
    }
  }
}
