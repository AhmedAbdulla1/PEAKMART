import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/features/products/data/models/product_model.dart';
import 'package:peakmart/features/products/presentation/views/products_view.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final ProductEntity products;

  ProductLoaded({required this.products});
}

class ProductError extends ProductState {
  final AppErrors error;
  final Function onRetry;

  ProductError({required this.error, required this.onRetry});
}
