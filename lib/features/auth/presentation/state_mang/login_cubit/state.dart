part of 'cubit.dart';

sealed class LoginState {}

final class LoginInitialState extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginFailureState extends LoginState {
  final AppErrors errors;
  final Function() onRetry;
  LoginFailureState({required this.errors, required this.onRetry});
}

final class LoginSuccessState extends LoginState {}
