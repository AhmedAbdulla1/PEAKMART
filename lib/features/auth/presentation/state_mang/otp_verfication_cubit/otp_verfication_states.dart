part of 'otp_verfication_cubit.dart';

sealed class OtpVerificationState {}

final class OtpVerificationInitialState extends OtpVerificationState {}

final class OtpVerificationLoadingState extends OtpVerificationState {}

final class OtpVerificationFailureState extends OtpVerificationState {
  final AppErrors errors;
  final Function() onRetry;

 OtpVerificationFailureState({required this.errors, required this.onRetry});
}

final class OtpVerificationSuccessState extends OtpVerificationState {
  bool isVerified;

  OtpVerificationSuccessState({this.isVerified = false});
}
final class SendOtpVerificationSuccessState extends OtpVerificationState {


  SendOtpVerificationSuccessState();
}
final class WatsAppOtpVerificationFailureState extends OtpVerificationState {
  final AppErrors errors;
  final Function() onRetry;

  WatsAppOtpVerificationFailureState({required this.errors, required this.onRetry});
}

final class WatsAppOtpVerificationSuccessState extends OtpVerificationState {

  WatsAppOtpVerificationSuccessState();
}