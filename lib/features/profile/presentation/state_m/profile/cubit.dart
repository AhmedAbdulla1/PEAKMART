// Profile Cubit (profile_cubit.dart)
// ===============================

import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/error_ui/toast.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/resources/color_manager.dart';
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

  static UserInfoEntity? _cachedUserInfo;

  late UserInfoEntity originalUserInfo;
  late UserInfoEntity currentUserInfo;
  String? tempProfileImagePath;
  bool _hasFetchedProfile = false;
  bool get hasChanges {
    final changes = _detectChanges();
    return changes.nameChanged || changes.emailChanged || changes.imageChanged;
  }

  void fetchProfileIfNeeded() {
    if (_hasFetchedProfile) return;

    if (_cachedUserInfo != null) {
      originalUserInfo = _cachedUserInfo!;
      currentUserInfo = _cachedUserInfo!;
      _hasFetchedProfile = true;
      emitLoaded();
      return;
    }

    fetchProfile();
  }

  void fetchProfile() async {
    emit(ProfileLoading());
    try {
      final result = await profileRepo.getUserInfo();
      result.pick(
        onData: (data) {
          originalUserInfo = data;
          currentUserInfo = data;
          _cachedUserInfo = data;
          _hasFetchedProfile = true;
          emitLoaded();
        },
        onError: (error) {
          emitError(error, fetchProfile);
          emitLoaded();
        },
      );
    } catch (e) {
      emitError(
        const AppErrors.customError(message: 'Failed to fetch profile'),
        fetchProfile,
      );
      emitLoaded();
    }
  }

  void invalidateCache() {
    _cachedUserInfo = null;
    _hasFetchedProfile = false;
  }

  void updateName(String name) =>
      _updateUserInfo(currentUserInfo.copyWith(userName: name));

  void updateEmail(String email) =>
      _updateUserInfo(currentUserInfo.copyWith(email: email));

  void updatePhoneNumber(String phone) =>
      _updateUserInfo(currentUserInfo.copyWith(phone: phone));

  void updateProfileImage(String imagePath) {
    tempProfileImagePath = imagePath;
    emit(ProfileLoaded(
      userInfo: currentUserInfo,
      tempProfileImagePath: tempProfileImagePath,
    ));
  }

  void updateCountry(String country) => _updateSellerField('COUNTRY', country);

  void updateCity(String city) => _updateSellerField('CITY', city);

  void updateGov(String gov) => _updateSellerField('GOV', gov);

  void updateAddress(String address) => _updateSellerField('ADDRESS', address);

  void _updateSellerField(String key, String value) {
    final updatedSellerInfo = {
      ...currentUserInfo.sellerInfo,
      key: value,
    };
    _updateUserInfo(currentUserInfo.copyWith(sellerInfo: updatedSellerInfo));
  }

  void _updateUserInfo(UserInfoEntity newInfo) {
    currentUserInfo = newInfo;
    emit(ProfileLoaded(
      userInfo: currentUserInfo,
      tempProfileImagePath: tempProfileImagePath,
    ));
  }

  Future<void> saveChanges(String password) async {
    emit(ProfileLoading());

    try {
      final changes = _detectChanges();
      final isSeller = appPreferences.getIsSeller();

      if (!changes.any) {
        emitLoaded();
        return;
      }

      if (changes.imageChanged) {
        final imageResult = await _updateProfileImage(password);
        bool imageSuccess = true;

        imageResult.pick(
          onData: (_) {},
          onError: (error) {
            emitError(error, () => saveChanges(password));
            emitLoaded();
            imageSuccess = false;
          },
        );

        if (!imageSuccess) return;
      }

      if (changes.infoChanged) {
        final profileResult = await _updateProfileInfo(password, isSeller);
        profileResult.pick(
          onData: (_) {
            Toast.show("Profile updated successfully",
                backgroundColor: ColorManager.green);
            invalidateCache();
            fetchProfile();
          },
          onError: (error) {
            emitError(error, () => saveChanges(password));
            emitLoaded();
          },
        );
      } else if (changes.imageChanged) {
        Toast.show("Profile image updated successfully",
            backgroundColor: ColorManager.green);
        invalidateCache();
        fetchProfile();
      }
    } catch (e) {
      emitError(
        const AppErrors.customError(message: 'Failed to save changes'),
        () => saveChanges(password),
      );
      emitLoaded();
    }
  }

  void logout({required VoidCallback onSuccess}) {
    invalidateCache();
    appPreferences.setIsSeller(false);

    appPreferences.logout().then((_) => onSuccess());
  }

  void emitLoaded({bool updateOriginal = false, bool fromCache = false}) {
    if (updateOriginal) {
      originalUserInfo = currentUserInfo;
      tempProfileImagePath = null;
    }

    emit(ProfileLoaded(
      userInfo: currentUserInfo,
      tempProfileImagePath: tempProfileImagePath,
    ));
  }

  void emitError(AppErrors error, VoidCallback onRetry) {
    emit(ProfileError(error: error, onRetry: onRetry));
  }

  _Changes _detectChanges() {
    final isSeller = appPreferences.getIsSeller();
    return _Changes(
      nameChanged: currentUserInfo.userName != originalUserInfo.userName,
      emailChanged: currentUserInfo.email != originalUserInfo.email,
      phoneChanged: currentUserInfo.phone != originalUserInfo.phone,
      imageChanged: tempProfileImagePath != null,
      sellerDataChanged: isSeller &&
          (currentUserInfo.sellerInfo["COUNTRY"] !=
                  originalUserInfo.sellerInfo["COUNTRY"] ||
              currentUserInfo.sellerInfo["CITY"] !=
                  originalUserInfo.sellerInfo["CITY"] ||
              currentUserInfo.sellerInfo["GOV"] !=
                  originalUserInfo.sellerInfo["GOV"] ||
              currentUserInfo.sellerInfo["ADDRESS"] !=
                  originalUserInfo.sellerInfo["ADDRESS"]),
    );
  }

  Future<Result<AppErrors, void>> _updateProfileImage(String password) {
    return profileRepo.updateProfileImage(UpdateProfileImageRequest(
      password: password,
      imagePath: tempProfileImagePath!,
    ));
  }

  Future<Result<AppErrors, void>> _updateProfileInfo(
      String password, bool isSeller) {
    return profileRepo.updateProfile(UpdateProfileRequest(
      userName: currentUserInfo.userName,
      email: currentUserInfo.email,
      phone: currentUserInfo.phone,
      password: password,
      country: isSeller ? currentUserInfo.sellerInfo["COUNTRY"] : null,
      city: isSeller ? currentUserInfo.sellerInfo["CITY"] : null,
      gov: isSeller ? currentUserInfo.sellerInfo["GOV"] : null,
      address: isSeller ? currentUserInfo.sellerInfo["ADDRESS"] : null,
    ));
  }
}

class _Changes {
  final bool nameChanged;
  final bool emailChanged;
  final bool phoneChanged;
  final bool imageChanged;
  final bool sellerDataChanged;

  _Changes({
    required this.nameChanged,
    required this.emailChanged,
    required this.phoneChanged,
    required this.imageChanged,
    required this.sellerDataChanged,
  });

  bool get any =>
      nameChanged ||
      emailChanged ||
      phoneChanged ||
      imageChanged ||
      sellerDataChanged;
  bool get infoChanged =>
      nameChanged || emailChanged || phoneChanged || sellerDataChanged;
}
