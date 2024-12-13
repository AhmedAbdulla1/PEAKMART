import 'package:dartz/dartz.dart';
import 'package:peakmart/core/constants/enums/http_method.dart';
import 'package:peakmart/core/data_source/remote_data_source.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/net/api_url.dart';
import 'package:peakmart/core/net/response_validators/default_response_validator.dart';
import 'package:peakmart/core/responses/emty_response.dart';
import 'package:peakmart/features/auth/data/model/request/login_request.dart';
import 'package:peakmart/features/auth/data/model/request/rest_password_request.dart';
import 'package:peakmart/features/auth/data/model/response/login_response.dart';



class AuthDataSource extends RemoteDataSource {
  Future<Either<AppErrors, LoginResponse>> login(LoginRequest loginRequest)  async {
    return request<LoginResponse>(
        method: HttpMethod.POST,
        body: loginRequest.toJson(),

        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return LoginResponse.fromJson(json);
        },
        url: APIUrls.login
    );
  }

  Future<Either<AppErrors, EmptyResponse>> restPassword(RestPasswordRequest resetPassword)  async {
    return request<EmptyResponse>(
        method: HttpMethod.POST,
        body: resetPassword.toJson(),

        responseValidator: DefaultResponseValidator(),
        converter: (json) {
          return EmptyResponse.fromJson(json);
        },
        url: APIUrls.resetPassword
    );
  }

}
