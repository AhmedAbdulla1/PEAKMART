import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';

sealed class RandomProductsState {}

final class RandomProductsInitialState extends RandomProductsState {}

final class RandomProductsLoadingState extends RandomProductsState {}

final class RandomProductsFailureState extends RandomProductsState {
  final AppErrors errors;
  final Function() onRetry;
  RandomProductsFailureState({required this.errors, required this.onRetry});
}

final class RandomProductsSuccessState extends RandomProductsState {
  final List<ProductEntity> randomProducts;

  RandomProductsSuccessState({required this.randomProducts});
}
