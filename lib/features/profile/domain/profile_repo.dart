import 'dart:io';

import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/profile/data/models/request/update_profile_image_request.dart';
import 'package:peakmart/features/profile/data/models/request/update_profile_request.dart';
import 'package:peakmart/features/profile/domain/enitiy/user_info_entity.dart';
import 'package:peakmart/features/profile/domain/enitiy/user_product_entity.dart';

abstract class ProfileRepo {
  Future<Result<AppErrors, UserInfoEntity>> getUserInfo();

  Future<Result<AppErrors, UserProductEntity>> getUserProducts();

  Future<Result<AppErrors, EmptyEntity>> updateProfileImage(
      UpdateProfileImageRequest updateProfileImageRequest);

  Future<Result<AppErrors, EmptyEntity>> updateProfile(
      UpdateProfileRequest updateProfileRequest);
}
