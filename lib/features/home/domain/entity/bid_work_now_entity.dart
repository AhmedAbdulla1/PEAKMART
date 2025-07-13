import 'package:Bid_Mart/core/entities/base_entity.dart';
import 'package:Bid_Mart/core/entities/prodcut_entity.dart';

class BidWorkNowEntity extends BaseEntity {
  final List<ProductEntity> data;

  const BidWorkNowEntity({required this.data});

  @override
  List<Object?> get props => data;
}
