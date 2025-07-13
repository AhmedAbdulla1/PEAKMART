import 'package:Bid_Mart/core/models/base_model.dart';
import 'package:Bid_Mart/features/profile/data/models/response/products_enrolled_res.dart';
import 'package:Bid_Mart/features/profile/domain/enitiy/user_products_enrolled_entity.dart';

class UserProductsEnrolledResponse
    extends BaseResponse<UserProductsEnrolledEntity> {
  final List<ProductsEnrolledResponse> data;

  UserProductsEnrolledResponse(
      {required this.data,
      required super.message,
      required super.status,
      required super.code});

  factory UserProductsEnrolledResponse.fromJson(Map<String, dynamic> json) {
    return UserProductsEnrolledResponse(
      data: List<ProductsEnrolledResponse>.from(json["data"].map(
          (productEnrolled) =>
              ProductsEnrolledResponse.fromJson(productEnrolled))),
      message: json["message"] ?? '',
      status: json["status"],
      code: 200,
    );
  }
  @override
  UserProductsEnrolledEntity toEntity() {
    return UserProductsEnrolledEntity(
      data: data.map((futureData) => futureData.toEntity()).toList(),
    );
  }
}
