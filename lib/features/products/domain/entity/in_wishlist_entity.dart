import 'package:Bid_Mart/core/entities/base_entity.dart';

class CheckWishlistEntity extends BaseEntity {
  final bool inWishlist;

  const CheckWishlistEntity({
    required this.inWishlist,
  });

  @override
  List<Object?> get props => [inWishlist];
}
