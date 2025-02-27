part of 'user_info_cubit.dart';



sealed class UserInfoState {}

final class UserInfoInitialState extends UserInfoState {}

final class UserInfoLoadingState extends UserInfoState {}

final class UserInfoFailureState extends UserInfoState {
  final AppErrors errors;
  final Function() onRetry;
  UserInfoFailureState({required this.errors, required this.onRetry});
}

final class UserInfoSuccessState extends UserInfoState {
  final UserInfoEntity userInfoEntity;
  UserInfoSuccessState({required this.userInfoEntity});
}
