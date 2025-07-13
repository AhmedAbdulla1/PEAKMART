import 'package:Bid_Mart/core/entities/base_entity.dart';
import 'package:Bid_Mart/core/entities/pagination_entity.dart';
import 'package:Bid_Mart/core/entities/prodcut_entity.dart';

class ProductsEntity extends BaseEntity {
  final List<ProductEntity> data;
  final PaginationEntity pagination;
  const ProductsEntity({required this.data, required this.pagination});

  @override
  List<Object?> get props => data;
}
