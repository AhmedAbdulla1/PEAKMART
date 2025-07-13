import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/features/home/domain/entity/category_entity.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final CategoriesEntity categoryEntity;

  CategoryLoaded(this.categoryEntity);
}

class CategoryError extends CategoryState {
  final AppErrors errors;
  // final VoidCallback onRetry;

  CategoryError(
    this.errors,
  );
}
