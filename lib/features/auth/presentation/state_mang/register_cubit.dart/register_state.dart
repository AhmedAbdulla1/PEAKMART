part of 'register_cubit.dart';

sealed class RegisterState {}

final class RegisterInitialState extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterFailureState extends RegisterState {
  final AppErrors errors;
  final Function() onRetry;
  RegisterFailureState({required this.errors, required this.onRetry});
}

final class RegisterSuccessState extends RegisterState {}
