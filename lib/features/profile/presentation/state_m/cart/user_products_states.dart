import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/features/profile/domain/enitiy/product_enrolled_entity.dart';

abstract class UserProductsStates {}

class UserProductsInitial extends UserProductsStates {}

class ProductUploadedLoading extends UserProductsStates {}
class ProductsEnrolledLoading extends UserProductsStates {}

class UserProductsLoaded extends UserProductsStates {
  final List<ProductEntity> products;

  UserProductsLoaded({required this.products});
}
class ProductsEnrolledLoaded extends UserProductsStates{
  final List<ProductsEnrolledEntity> products;

  ProductsEnrolledLoaded({required this.products});
}

class UserProductsError extends UserProductsStates {
  final AppErrors error;
  final Function onRetry;

  UserProductsError({required this.error, required this.onRetry});
}
