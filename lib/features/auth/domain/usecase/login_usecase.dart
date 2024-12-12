import 'package:dartz/dartz.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/app/errors/app_errors.dart';
import 'package:peakmart/app/results/result.dart';
import 'package:peakmart/features/auth/data/model/request/login_request.dart';
import 'package:peakmart/features/auth/domain/entity/login_entity.dart';
import 'package:peakmart/features/auth/domain/repository/auth_repo.dart';

class LoginUsecase {
  final  AuthRepo authRepo = instance<AuthRepo>();
  Future<Result<AppErrors,LoginEntity>> login(LoginRequest loginRequest) async {
    return await authRepo.login(loginRequest);
  }


}
