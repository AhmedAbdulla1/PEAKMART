part of 'sign_up_cubit.dart';

sealed class SignUpState {}

final class SignUpInitialState extends SignUpState {}

final class SignUpLoadingState extends SignUpState {}

final class SignUpFailureState extends SignUpState {
  final String errorMessage;
  SignUpFailureState({required this.errorMessage});
}

final class SignUpSuccessState extends SignUpState {}
