import 'package:peakmart/core/entities/base_entity.dart';
import 'package:peakmart/features/profile/domain/enitiy/product_enrolled_entity.dart';

class UserProductsEnrolledEntity extends BaseEntity {
  final List<ProductsEnrolledEntity> data;

  const UserProductsEnrolledEntity({required this.data});

  @override
  List<Object?> get props => data;
}
