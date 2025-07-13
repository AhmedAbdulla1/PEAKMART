import 'package:Bid_Mart/core/models/base_model.dart';
import 'package:Bid_Mart/features/products/domain/entity/in_wishlist_entity.dart';

class CheckWishlistResponse extends BaseResponse<CheckWishlistEntity> {
  final bool inWishlist;
  CheckWishlistResponse(
      {required this.inWishlist,
        required super.message,
        required super.status,
        required super.code});

  factory CheckWishlistResponse.fromJson(Map<String, dynamic> json) {
    return CheckWishlistResponse(
      inWishlist: json['in_wishlist'],
      message: json["message"] ?? "",
      status: json["status"] ?? 'error',
      code: 200,

    );
  }

  @override
  CheckWishlistEntity toEntity() {
    return CheckWishlistEntity(
      inWishlist: inWishlist
    );
  }
}
