import 'package:dartz/dartz.dart';
import 'package:peakmart/app/constants/enums/http_method.dart';
import 'package:peakmart/app/data_source/remote_data_source.dart';
import 'package:peakmart/app/errors/app_errors.dart';
import 'package:peakmart/app/net/api_url.dart';
import 'package:peakmart/features/auth/data/model/request/login_request.dart';
import 'package:peakmart/features/auth/data/model/response/login_response.dart';



class AuthDataSource extends RemoteDataSource {



  Future<Either<AppErrors, LoginResponse>> login(LoginRequest loginRequest)  async {
    return request(
        method: HttpMethod.POST,
        body: loginRequest.toJson(),
        converter: (json) {
          return LoginResponse.fromJson(json);
        },
        url: APIUrls.login
    );
  }
}
