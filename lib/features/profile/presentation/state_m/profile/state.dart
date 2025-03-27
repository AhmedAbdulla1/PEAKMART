part of 'cubit.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserInfoEntity userInfo;
  final String? tempProfileImagePath; // Temporary path for the new profile image (if changed)

  const ProfileLoaded({
    required this.userInfo,
    this.tempProfileImagePath,
  });
}

class ProfileError extends ProfileState {
  final AppErrors error;
  final VoidCallback onRetry;

  const ProfileError({required this.error, required this.onRetry});
}

class ProfileOtpSent extends ProfileState {
  final String type; // "phone" or "email"
  final String value; // The phone number or email to which OTP was sent

  const ProfileOtpSent(this.type, this.value);
}