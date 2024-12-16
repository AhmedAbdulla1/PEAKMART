part of 'otp_verfication_cubit.dart';

sealed class OtpVerficationState {}

final class OtpVerficationInitialState extends OtpVerficationState {}

final class OtpVerficationLoadingState extends OtpVerficationState {}

final class OtpVerficationFailureState extends OtpVerficationState {
  final AppErrors errors;
  final Function() onRetry;

 OtpVerficationFailureState({required this.errors, required this.onRetry});
}

final class OtpVerficationSuccessState extends OtpVerficationState {
  bool isVerified;

  OtpVerficationSuccessState({this.isVerified = false});
}
