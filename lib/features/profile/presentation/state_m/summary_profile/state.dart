// states/profile_state.dart
part of 'cubit.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final SummaryProfileModel summaryProfileModel;

  const ProfileLoaded({
    required this.summaryProfileModel,
  });
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);
}
class SummaryProfileModel{
  final String name;
  final String email;
  final double points;
  final bool personalInfoCompleted;
  final bool paymentCompleted;

  const SummaryProfileModel({
    required this.name,
    required this.email,
    required this.points,
    required this.personalInfoCompleted,
    required this.paymentCompleted,
  });
}