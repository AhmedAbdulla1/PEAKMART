import 'package:Bid_Mart/core/entities/base_entity.dart';
import 'package:Bid_Mart/features/profile/domain/enitiy/product_enrolled_entity.dart';

class UserProductsEnrolledEntity extends BaseEntity {
  final List<ProductsEnrolledEntity> data;

  const UserProductsEnrolledEntity({required this.data});

  @override
  List<Object?> get props => data;
}
