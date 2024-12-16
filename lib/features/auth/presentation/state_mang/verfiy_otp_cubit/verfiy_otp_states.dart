part of 'verfiy_otp_cubit.dart';


sealed class VerfiyOtpStates {}

final class VerfiyOtpInitialState extends VerfiyOtpStates {}

final class VerfiyOtpLoadingState extends VerfiyOtpStates {}

final class VerfiyOtpFailureState extends VerfiyOtpStates {
  final AppErrors errors;
  final Function() onRetry;
  VerfiyOtpFailureState({required this.errors, required this.onRetry});
}

final class VerfiyOtpSuccessState extends VerfiyOtpStates {}
