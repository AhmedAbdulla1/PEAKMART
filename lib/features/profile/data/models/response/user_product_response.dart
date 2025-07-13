import 'package:Bid_Mart/core/models/base_model.dart';
import 'package:Bid_Mart/core/responses/product_response.dart';
import 'package:Bid_Mart/features/profile/domain/enitiy/user_product_entity.dart';

class UserProductResponse extends BaseResponse<UserProductEntity> {
  final List<ProductResponse> data;

  UserProductResponse(
      {required this.data,
      required super.message,
      required super.status,
      required super.code});

  factory UserProductResponse.fromJson(Map<String, dynamic> json) {
    return UserProductResponse(
      data: List<ProductResponse>.from(json["data"]
          .map((futureData) => ProductResponse.fromJson(futureData))),
      message: json["message"]??'',
      status: json["status"],
      code: 200,
    );
  }

  @override
  UserProductEntity toEntity() {
    return UserProductEntity(
      data: data.map((futureData) => futureData.toEntity()).toList(),
    );
  }
}
