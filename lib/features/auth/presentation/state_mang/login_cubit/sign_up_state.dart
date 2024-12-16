part of 'sign_up_cubit.dart';

sealed class LoginState {}

final class SignUpInitialState extends LoginState {}

final class SignUpLoadingState extends LoginState {}

final class SignUpFailureState extends LoginState {
  final AppErrors errors;
  final Function() onRetry;
  SignUpFailureState({required this.errors, required this.onRetry});
}

final class SignUpSuccessState extends LoginState {}
