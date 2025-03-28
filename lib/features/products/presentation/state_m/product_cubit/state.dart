import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;

  ProductLoaded({required this.products});
}

class ProductError extends ProductState {
  final AppErrors error;
  final Function onRetry;

  ProductError({required this.error, required this.onRetry});
}
