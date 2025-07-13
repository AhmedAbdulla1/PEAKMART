import 'package:Bid_Mart/core/entities/base_entity.dart';

class CheckIsSellerEntity extends BaseEntity {
  final bool isSeller;

  const CheckIsSellerEntity({required this.isSeller});

  @override
  List<Object?> get props => [];
}
