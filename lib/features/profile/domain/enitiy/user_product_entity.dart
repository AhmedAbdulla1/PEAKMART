import 'package:Bid_Mart/core/entities/base_entity.dart';
import 'package:Bid_Mart/core/entities/prodcut_entity.dart';

class UserProductEntity extends BaseEntity {
  final List<ProductEntity> data;

  const UserProductEntity({required this.data});

  @override
  List<Object?> get props => data;
}
