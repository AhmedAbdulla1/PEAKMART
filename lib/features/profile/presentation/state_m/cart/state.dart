import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<ProductEntity> products;

  CartLoaded({required this.products});
}

class CartError extends CartState {
  final AppErrors error;
  final Function onRetry;

  CartError({required this.error, required this.onRetry});
}
