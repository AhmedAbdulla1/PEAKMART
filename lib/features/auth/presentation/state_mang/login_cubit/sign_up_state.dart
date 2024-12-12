part of 'sign_up_cubit.dart';

sealed class SignUpState {}

final class SignUpInitialState extends SignUpState {}

final class SignUpLoadingState extends SignUpState {}

final class SignUpFailureState extends SignUpState {
  final AppErrors errors;
  final Function() onRetry;
  SignUpFailureState({required this.errors, required this.onRetry});
}

final class SignUpSuccessState extends SignUpState {}
