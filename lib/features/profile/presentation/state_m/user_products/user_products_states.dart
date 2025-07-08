import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/features/products/domain/entity/prodcuts_entity.dart';
import 'package:peakmart/features/profile/domain/enitiy/product_enrolled_entity.dart';

abstract class UserProductsStates {}

class UserProductsInitial extends UserProductsStates {}

class ProductUploadedLoading extends UserProductsStates {}

class ProductsEnrolledLoading extends UserProductsStates {}

class WishListLoading extends UserProductsStates {}

class UserProductsLoaded extends UserProductsStates {
  final List<ProductEntity> products;

  UserProductsLoaded({required this.products});
}

class ProductsEnrolledLoaded extends UserProductsStates {
  final List<ProductsEnrolledEntity> products;

  ProductsEnrolledLoaded({required this.products});
}

class WishListLoaded extends UserProductsStates {
  final List<ProductEntity> products;

  WishListLoaded({required this.products});
}

class UserProductsError extends UserProductsStates {
  final AppErrors error;
  final Function onRetry;

  UserProductsError({required this.error, required this.onRetry});
}

class ProductEnrolledError extends UserProductsStates {
  final AppErrors error;
  final Function onRetry;

  ProductEnrolledError({required this.error, required this.onRetry});
}
class WishlistError extends UserProductsStates {
  final AppErrors error;
  final Function onRetry;

  WishlistError({required this.error, required this.onRetry});
}

class CancelUserProductLoading extends UserProductsStates {}

class CancelUserProductSuccess extends UserProductsStates {}

class EndUserProductSuccess extends UserProductsStates {}

class CancelUserProductFailed extends UserProductsStates {
  final AppErrors error;

  CancelUserProductFailed({required this.error});
}
