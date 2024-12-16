import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/auth/data/model/request/verfiy_otp_request.dart';
import 'package:peakmart/features/auth/domain/repository/auth_repo.dart';

part 'verfiy_otp_states.dart';

class VerfiyOtpCubit extends Cubit<VerfiyOtpStates> {
  AuthRepo authRepo = instance<AuthRepo>();
  String otp = '';
  VerfiyOtpCubit() : super(VerfiyOtpInitialState());

  Future<void> resetPassword({required String otp}) async {
    this.otp = otp;
    emit(VerfiyOtpLoadingState());
    Result<AppErrors, EmptyEntity> result =
        await authRepo.verfiyOtp(VerfiyOtpRequest(
      otp: otp,
    ));
    result.pick(onData: (data) {
      emit(VerfiyOtpSuccessState());
    }, onError: (error) {
      debugPrint(
        error.toString(),
      );
      emit(
        VerfiyOtpFailureState(
          errors: error,
          onRetry: () {},
        ),
      );
    });
  }
}
