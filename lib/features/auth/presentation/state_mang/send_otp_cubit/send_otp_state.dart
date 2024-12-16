part of 'send_otp_cubit.dart';

sealed class SendOtpState {}

final class SendOtpInitialState extends SendOtpState {}

final class SendOtpLoadingState extends SendOtpState {}

final class SendOtpFailureState extends SendOtpState {
  final AppErrors errors;
  final Function() onRetry;

  SendOtpFailureState({required this.errors, required this.onRetry});
}

final class SendOtpSuccessState extends SendOtpState {}
