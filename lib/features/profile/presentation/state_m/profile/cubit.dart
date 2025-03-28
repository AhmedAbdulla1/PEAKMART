import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/profile/data/models/request/update_profile_image_request.dart';
import 'package:peakmart/features/profile/data/models/request/update_profile_request.dart';
import 'package:peakmart/features/profile/domain/enitiy/user_info_entity.dart';
import 'package:peakmart/features/profile/domain/profile_repo.dart';

part 'state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo = instance<ProfileRepo>();
  final AppPreferences appPreferences = instance<AppPreferences>();

  ProfileCubit() : super(ProfileInitial());

  // Original and current user info instances
  late UserInfoEntity originalUserInfo;
  late UserInfoEntity currentUserInfo;
  String? tempProfileImagePath; // Temporary path for the new profile image

  void fetchProfile() async {
    emit(ProfileLoading());
    try {
      Result<AppErrors, UserInfoEntity> result =
          await profileRepo.getUserInfo();
      result.pick(
        onData: (data) {
          // Initialize original and current user info
          originalUserInfo = data;
          currentUserInfo = data;

          emit(ProfileLoaded(
            userInfo: currentUserInfo,
            tempProfileImagePath: tempProfileImagePath,
          ));
        },
        onError: (error) {
          log(error.toString());
          emit(ProfileError(
            error: error,
            onRetry: fetchProfile,
          ));
        },
      );
    } catch (e) {
      emit(ProfileError(
        error: const AppErrors.customError(message: 'Failed to fetch profile'),
        onRetry: fetchProfile,
      ));
    }
  }

  // Update name
  void updateName(String name) {
    currentUserInfo = currentUserInfo.copyWith(userName: name);
    emit(ProfileLoaded(
      userInfo: currentUserInfo,
      tempProfileImagePath: tempProfileImagePath,
    ));
  }

  // Update email
  void updateEmail(String email) {
    currentUserInfo = currentUserInfo.copyWith(email: email);
    emit(ProfileLoaded(
      userInfo: currentUserInfo,
      tempProfileImagePath: tempProfileImagePath,
    ));
  }

  // Update phone number
  void updatePhoneNumber(String phoneNumber) {
    currentUserInfo = currentUserInfo.copyWith(phone: phoneNumber);
    emit(ProfileLoaded(
      userInfo: currentUserInfo,
      tempProfileImagePath: tempProfileImagePath,
    ));
  }

  // Update profile image
  void updateProfileImage(String imagePath) {
    tempProfileImagePath = imagePath;
    emit(ProfileLoaded(
      userInfo: currentUserInfo,
      tempProfileImagePath: tempProfileImagePath,
    ));
  }

  // Save changes and detect which fields have changed
  Future<void> saveChanges(String password) async {
    emit(ProfileLoading());

    try {
      bool nameChanged = currentUserInfo.userName != originalUserInfo.userName;
      bool emailChanged = currentUserInfo.email != originalUserInfo.email;
      bool phoneChanged = currentUserInfo.phone != originalUserInfo.phone;
      bool imageChanged = tempProfileImagePath != null;

      // Update profile image if changed
      if (imageChanged) {
        Result<AppErrors, EmptyEntity> result =
            await profileRepo.updateProfileImage(
                UpdateProfileImageRequest(
                    password: password,
                    imagePath: tempProfileImagePath!));
        result.pick(
          onData: (newImageUrl) {
            // currentUserInfo = currentUserInfo.copyWith(photo: newImageUrl);
            // originalUserInfo = originalUserInfo.copyWith(photo: newImageUrl);
            // tempProfileImagePath = null;
          },
          onError: (error) {
            emit(ProfileError(
              error: error,
              onRetry:()=>saveChanges(password),

            ));
            return;
          },
        );
      }

      if (nameChanged || emailChanged) {
        Result<AppErrors, EmptyEntity> result = await profileRepo.updateProfile(
            UpdateProfileRequest(
                userName: currentUserInfo.userName,
                email: currentUserInfo.email,
                phone: currentUserInfo.phone,
                password: password
            ));
        result.pick(
          onData: (success) {
            originalUserInfo =
                originalUserInfo.copyWith(userName: currentUserInfo.userName);
          },
          onError: (error) {
            emit(ProfileError(
              error: error,
              onRetry:()=> saveChanges(password),
            ));
            return;
          },
        );
      }
      emit(ProfileLoaded(
        userInfo: currentUserInfo,
        tempProfileImagePath: tempProfileImagePath,
      ));
    } catch (e) {
      emit(ProfileError(
        error: const AppErrors.customError(message: 'Failed to save changes'),
        onRetry: ()=>saveChanges(password),
      ));
    }
  }

  void logout({required onSuccess}) {
    appPreferences.logout().then((onValue) => onSuccess());
  }
}
