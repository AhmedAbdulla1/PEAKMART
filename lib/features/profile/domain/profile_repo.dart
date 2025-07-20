import 'package:Bid_Mart/core/entities/empty_entity.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/profile/data/models/request/cancle_user_product_request.dart';
import 'package:Bid_Mart/features/profile/data/models/request/own_product_request.dart';
import 'package:Bid_Mart/features/profile/data/models/request/update_profile_image_request.dart';
import 'package:Bid_Mart/features/profile/data/models/request/update_profile_request.dart';
import 'package:Bid_Mart/features/profile/domain/enitiy/user_info_entity.dart';
import 'package:Bid_Mart/features/profile/domain/enitiy/user_product_entity.dart';
import 'package:Bid_Mart/features/profile/domain/enitiy/user_products_enrolled_entity.dart';

abstract class ProfileRepo {
  Future<Result<AppErrors, UserInfoEntity>> getUserInfo();

  Future<Result<AppErrors, UserProductEntity>> getProductsUploaded();
  Future<Result<AppErrors, UserProductsEnrolledEntity>> getProductsEnrolled();
  Future<Result<AppErrors, UserProductEntity>> getWishListProducts();

  Future<Result<AppErrors, EmptyEntity>> cancelUserProduct(CancelUserProductRequest cancelProductRequest);

  Future<Result<AppErrors, EmptyEntity>> updateProfileImage(
      UpdateProfileImageRequest updateProfileImageRequest);

  Future<Result<AppErrors, EmptyEntity>> updateProfile(
      UpdateProfileRequest updateProfileRequest);


  Future<Result<AppErrors, EmptyEntity>> ownProducts( OwnProductRequest ownProductRequest);
  Future<Result<AppErrors, EmptyEntity>> logout();
}
