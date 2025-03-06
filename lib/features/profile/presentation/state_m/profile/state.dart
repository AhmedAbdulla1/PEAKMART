// states/profile_state.dart
part of 'cubit.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserInfoEntity userInfo;

  const ProfileLoaded({
    required this.userInfo,
  });
}

class ProfileError extends ProfileState {
  final AppErrors error;
  final VoidCallback onRetry;
  const ProfileError( { required this.error, required this.onRetry});
}