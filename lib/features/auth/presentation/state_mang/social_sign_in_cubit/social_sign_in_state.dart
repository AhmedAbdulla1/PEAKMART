part of 'social_sign_in_cubit.dart';

sealed class SignInWithSocialState {}

final class SignInWithSocialInitialState extends SignInWithSocialState {}

final class SignInWithSocialLoadingState extends SignInWithSocialState {
  SignInWithSocialLoadingState();
}

final class SignInWithSocialSuccessState extends SignInWithSocialState {
  SignInWithSocialSuccessState();
}

final class SignInWithSocialFailureState extends SignInWithSocialState {
  final String errorMessage;

  SignInWithSocialFailureState({
    required this.errorMessage,
  });
}
