import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/auth/data/model/request/send_otp_request.dart';
import 'package:peakmart/features/auth/data/model/request/verfiy_otp_request.dart';
import 'package:peakmart/features/auth/domain/entity/send_otp_entity.dart';
import 'package:peakmart/features/auth/domain/repository/auth_repo.dart';

part 'otp_verfication_states.dart';

class OtpVerfictionCubit extends Cubit<OtpVerificationState> {
  AuthRepo authRepo = instance<AuthRepo>();

  OtpVerfictionCubit() : super(OtpVerificationInitialState());
  bool isOtpVerified = false;
  String otp = '';

// late BuildContext context;
  Future<void> sendOtp({
    required SendOtpRequest sendOtpRequest,
  }) async {
    emit(
      OtpVerificationLoadingState(),
    );

    debugPrint('in cubit key is ${sendOtpRequest.key}');
    Result<AppErrors, SendOtpEntity> result =
        await authRepo.sendOtp(SendOtpRequest(
      email: sendOtpRequest.email,
      username: sendOtpRequest.username,
      key: sendOtpRequest.key,
    ));

    result.pick(onData: (data) {
      debugPrint(
        'data in cubit is $data',
      );
      // Navigator.pop(context);
      emit(
        OtpVerificationSuccessState(),
      );
    }, onError: (error) {
      debugPrint(
        error.toString(),
      );
      // Navigator.pop(context);
      emit(
        OtpVerificationFailureState(
          errors: error,
          onRetry: () {},
        ),
      );
    });
  }

  Future<void> verfiyOtp({required VerfiyOtpRequest verfiyOtpRequest}) async {
    otp = verfiyOtpRequest.otp;
    emit(OtpVerificationLoadingState());
    // ShowDialog().showElasticDialog(
    //   context: context,
    //   builder: (context) => const WaitingWidget(),
    //   barrierDismissible: false,
    // );
    Result<AppErrors, EmptyEntity> result = await authRepo.verfiyOtp(
      VerfiyOtpRequest(
        otp: verfiyOtpRequest.otp,
        email: verfiyOtpRequest.email,
        username: verfiyOtpRequest.username,
      ),
    );

    result.pick(
      onData: (data) {
        debugPrint(
          'in otp verification data is $data, otp is $otp',
        );
        // Navigator.pop(context);

        emit(
          OtpVerificationSuccessState(isVerified: true),
        );
      },
      onError: (error) {
        debugPrint(
          error.toString(),
        );
        // Navigator.pop(context);
        emit(
          OtpVerificationFailureState(
            errors: error,
            onRetry: () {},
          ),
        );
      },
    );
  }

  Future<void> sendWatsAppOtp(// required SendOtpRequest sendOtpRequest,
      ) async {
    emit(
      OtpVerificationLoadingState(),
    );
    Result<AppErrors, EmptyEntity> result = await authRepo.sendWatsAppOtp();

    result.pick(onData: (data) {
      debugPrint(
        'data in cubit is $data',
      );
      // Navigator.pop(context);
      emit(
        OtpVerificationSuccessState(),
      );
    }, onError: (error) {
      debugPrint(
        error.toString(),
      );
      // Navigator.pop(context);
      emit(
        OtpVerificationFailureState(
          errors: error,
          onRetry: () {},
        ),
      );
    });
  }

  Future<void> verifyWatsAppOtp({
    required VerfiyOtpRequest verifyOtpRequest,
  }) async {
    emit(
      OtpVerificationLoadingState(),
    );

    debugPrint('in cubit key is ${verifyOtpRequest.otp}');
    Result<AppErrors, EmptyEntity> result =
        await authRepo.verfiyWatsAppOtp(verifyOtpRequest);

    result.pick(onData: (data) {
      debugPrint(
        'data in cubit is $data',
      );
      // Navigator.pop(context);
      emit(
        OtpVerificationSuccessState(isVerified: true),
      );
    }, onError: (error) {
      debugPrint(
        error.toString(),
      );
      // Navigator.pop(context);
      emit(
        OtpVerificationFailureState(
          errors: error,
          onRetry: () {},
        ),
      );
    });
  }
}
