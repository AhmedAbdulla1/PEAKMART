part of 'cubit.dart';

sealed class ResetPassState {}

final class ResetPassInitialState extends ResetPassState {}

final class ResetPassLoadingState extends ResetPassState {}

final class ResetPassFailureState extends ResetPassState {
  final AppErrors errors;
  final Function() onRetry;
  ResetPassFailureState({required this.errors, required this.onRetry});
}

final class ResetPassSuccessState extends ResetPassState {}
