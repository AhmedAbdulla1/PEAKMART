part of 'cubit.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final AppErrors error;
//dda
  SignUpFailure({required this.error});
}

class SignUpDetailsLoading extends SignUpState {}

class SignUpDetailsSuccess extends SignUpState {}

class SignUpDetailsFailure extends SignUpState {
  final AppErrors error;
  final Function() onRetry;
  SignUpDetailsFailure({required this.error,required this.onRetry});
}