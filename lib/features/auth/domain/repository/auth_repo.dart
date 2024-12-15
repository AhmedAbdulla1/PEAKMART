import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/auth/data/model/request/login_request.dart';
import 'package:peakmart/features/auth/data/model/request/rest_password_request.dart';
import 'package:peakmart/features/auth/domain/entity/login_entity.dart';

abstract class AuthRepo {

  Future<Result<AppErrors,LoginEntity>> login(LoginRequest loginRequest);
  Future<Result<AppErrors,EmptyEntity>> restPassword(RestPasswordRequest resetPassword);

}
