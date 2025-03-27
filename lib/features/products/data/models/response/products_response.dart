import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/core/responses/product_response.dart';
import 'package:peakmart/features/home/domain/entity/ended_bids_entity.dart';
import 'package:peakmart/features/products/domain/entity/prodcuts_entity.dart';

class ProductsResponse extends BaseResponse<ProductsEntity> {
  final List<ProductResponse> data;

  ProductsResponse(
      {required this.data,
      required super.message,
      required super.status,
      required super.code});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      data: List<ProductResponse>.from(json["data"]
          .map((endedBidsData) => ProductResponse.fromJson(endedBidsData))),
      message: json["message"],
      status: json["status"],
      code: 200,
    );
  }

  @override
  ProductsEntity toEntity() {
    return ProductsEntity(
      data: data.map((endedBidsData) => endedBidsData.toEntity()).toList(),
    );
  }
}
