import 'package:Bid_Mart/core/models/base_model.dart';
import 'package:Bid_Mart/core/responses/pagination_response.dart';
import 'package:Bid_Mart/core/responses/product_response.dart';
import 'package:Bid_Mart/features/products/domain/entity/prodcuts_entity.dart';

class ProductsResponse extends BaseResponse<ProductsEntity> {
  final List<ProductResponse> data;
  final PaginationResponse paginationResponse;
  ProductsResponse(
      {required this.data,
      required this.paginationResponse,
      required super.message,
      required super.status,
      required super.code});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];

    List<ProductResponse> products;
    if (rawData is List) {
      products = rawData
          .map((item) =>
              ProductResponse.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } else if (rawData is Map) {
      products = [ProductResponse.fromJson(Map<String, dynamic>.from(rawData))];
    } else {
      throw const FormatException(
          "Unexpected data format for product response");
    }

    return ProductsResponse(
      data: products,
      message: json["message"] ?? "",
      status: json["status"] ?? '',
      code: 200,
      paginationResponse: json["pagination"] != null
          ? PaginationResponse.fromJson(
              Map<String, dynamic>.from(json["pagination"]))
          : PaginationResponse.empty(),
    );
  }

  @override
  ProductsEntity toEntity() {
    return ProductsEntity(
      pagination: paginationResponse.toEntity(),
      data: data.map((product) => product.toEntity()).toList(),
    );
  }
}
