import 'package:peakmart/core/entities/base_entity.dart';

class CategoriesEntity extends BaseEntity {
  final List<CategoryEntity> categories;

  const CategoriesEntity({
    required this.categories,
  });

  @override
  List<Object?> get props => [categories];
}

class CategoryEntity {
  final int catId;
  final String catName;
  final int noOfProducts;

  CategoryEntity({
    required this.catId,
    required this.catName,
    required this.noOfProducts,
  });

  @override
  List<Object?> get props => [catId, catName, noOfProducts];
}
