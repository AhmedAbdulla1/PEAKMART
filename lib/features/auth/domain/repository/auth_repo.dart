import 'package:dartz/dartz.dart';
import 'package:peakmart/app/errors/app_errors.dart';
import 'package:peakmart/app/results/result.dart';
import 'package:peakmart/features/auth/data/model/request/login_request.dart';
import 'package:peakmart/features/auth/domain/entity/login_entity.dart';

abstract class AuthRepo {

  Future<Result<AppErrors,LoginEntity>> login(LoginRequest loginRequest);
}
