// cubit/profile_cubit.dart
import 'dart:developer';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/profile/domain/enitiy/user_info_entity.dart';
import 'package:peakmart/features/profile/domain/profile_repo.dart';

part 'state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo = instance<ProfileRepo>();

  ProfileCubit() : super(ProfileInitial());

  void fetchProfile() async {
    emit(ProfileLoading());
    try {
      // Simulate fetching profile data from an API
      Result<AppErrors, UserInfoEntity> result =
          await profileRepo.getUserInfo();
      result.pick(onData: (data) {
        emit(
          ProfileLoaded(userInfo: data),
        );
      }, onError: (error) {
        log(
          error.toString(),
        );
        // Navigator.pop(context);
        emit(
          ProfileError(
            error: error,
            onRetry: () {},
          ),
        );
      });
    } catch (e) {
      emit(ProfileError(
          error: const AppErrors.customError(message: 'Failed to fetch profile'),
          onRetry: () {
            fetchProfile();
          }));
    }
  }
  final AppPreferences appPreferences = instance<AppPreferences>();
  void logout({required VoidCallback onSuccess}) {
    appPreferences.logout().then((onValue) => onSuccess());
  }
}
