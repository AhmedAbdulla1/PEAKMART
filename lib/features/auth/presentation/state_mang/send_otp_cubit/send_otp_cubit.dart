import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/auth/data/model/request/send_otp_request.dart';
import 'package:peakmart/features/auth/domain/entity/send_otp_entity.dart';
import 'package:peakmart/features/auth/domain/repository/auth_repo.dart';

part 'send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  AuthRepo authRepo = instance<AuthRepo>();

  SendOtpCubit() : super(SendOtpInitialState());

  Future<void> sendOtp({required SendOtpRequest sendOtpRequest}) async {
    emit(
      SendOtpLoadingState(),
    );
    debugPrint('in cubit key is ${sendOtpRequest.key}');
    Result<AppErrors, SendOtpEntity> result = await authRepo.sendOtp(
      SendOtpRequest(
          key: sendOtpRequest.key,
      )
    );
    emit(
      SendOtpSuccessState(),
    );
    result.pick(onData: (data) {
      debugPrint(
        'data in cubit is $data',
      );
      emit(
        SendOtpSuccessState(),
      );
    }, onError: (error) {
      debugPrint(
        error.toString(),
      );
      emit(
        SendOtpFailureState(
          errors: error,
          onRetry: () {},
        ),
      );
    });
  }
}
