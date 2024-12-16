import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/auth/data/model/request/login_request.dart';
import 'package:peakmart/features/auth/data/model/request/register_request.dart';
import 'package:peakmart/features/auth/data/model/request/rest_password_request.dart';
import 'package:peakmart/features/auth/data/model/request/send_otp_request.dart';
import 'package:peakmart/features/auth/domain/entity/login_entity.dart';
import 'package:peakmart/features/auth/domain/entity/register_entity.dart';
import 'package:peakmart/features/auth/domain/entity/send_otp_entity.dart';

abstract class AuthRepo {

  Future<Result<AppErrors,LoginEntity>> login(LoginRequest loginRequest);
  Future<Result<AppErrors,EmptyEntity>> restPassword(RestPasswordRequest resetPassword);
  Future<Result<AppErrors, RegisterEntity>> register(
      RegisterRequest registerRequest);
  Future<Result<AppErrors, SendOtpEntity>> sendOtp(
      SendOtpRequest sendOtpRequest);
}
