import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/features/auth/data/model/request/send_otp_request.dart';
import 'package:Bid_Mart/features/auth/data/model/request/verfiy_otp_request.dart';
import 'package:Bid_Mart/features/auth/domain/repository/auth_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_verfication_states.dart';

class OtpVerfictionCubit extends Cubit<OtpVerificationState> {
  final AuthRepo _authRepo = instance<AuthRepo>();

  OtpVerfictionCubit() : super(OtpVerificationInitialState());

  String otp = '';

  Future<void> sendOtp({
    required SendOtpRequest sendOtpRequest,
  }) async {
    emit(OtpVerificationLoadingState());
    debugPrint('➡️ Sending OTP with key: ${sendOtpRequest.key}');

    final result = await _authRepo.sendOtp(sendOtpRequest);

    result.pick(
      onData: (_) {
        debugPrint('✅ OTP sent successfully');
        emit(SendOtpVerificationSuccessState());
      },
      onError: (error) {
        debugPrint('❌ Error sending OTP: $error');
        emit(OtpVerificationFailureState(
            errors: error,
            onRetry: () {
              sendOtp(sendOtpRequest: sendOtpRequest);
            }));
      },
    );
  }

  Future<void> verfiyOtp({
    required VerfiyOtpRequest verfiyOtpRequest,
  }) async {
    otp = verfiyOtpRequest.otp;
    emit(OtpVerificationLoadingState());
    debugPrint('➡️ Verifying OTP: $otp');

    final result = await _authRepo.verfiyOtp(verfiyOtpRequest);

    result.pick(
      onData: (_) {
        debugPrint('✅ OTP verified successfully');
        emit(OtpVerificationSuccessState(isVerified: true));
      },
      onError: (error) {
        debugPrint('❌ OTP verification failed: $error');
        emit(OtpVerificationFailureState(
            errors: error,
            onRetry: () {
              verfiyOtp(verfiyOtpRequest: verfiyOtpRequest);
            }));
      },
    );
  }

  Future<void> sendWatsAppOtp() async {
    emit(OtpVerificationLoadingState());
    debugPrint('➡️ Sending WhatsApp OTP');

    final result = await _authRepo.sendWatsAppOtp();

    result.pick(
      onData: (_) {
        debugPrint('✅ WhatsApp OTP sent');
        emit(SendOtpVerificationSuccessState());
      },
      onError: (error) {
        debugPrint('❌ WhatsApp OTP send failed: $error');
        emit(OtpVerificationFailureState(
            errors: error, onRetry: sendWatsAppOtp));
      },
    );
  }

  Future<void> verifyWatsAppOtp({
    required VerfiyOtpRequest verifyOtpRequest,
  }) async {
    emit(OtpVerificationLoadingState());
    debugPrint('➡️ Verifying WhatsApp OTP: ${verifyOtpRequest.otp}');

    final result = await _authRepo.verfiyWatsAppOtp(verifyOtpRequest);

    result.pick(
      onData: (_) {
        debugPrint('✅ WhatsApp OTP verified');
        emit(WatsAppOtpVerificationSuccessState());
      },
      onError: (error) {
        debugPrint('❌ WhatsApp OTP verification failed: $error');
        emit(OtpVerificationFailureState(
            errors: error,
            onRetry: () {
              verifyWatsAppOtp(verifyOtpRequest: verifyOtpRequest);
            }));
      },
    );
  }
}
