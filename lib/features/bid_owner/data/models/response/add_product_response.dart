import 'dart:developer';

import 'package:peakmart/core/entities/base_entity.dart';
import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/features/bid_owner/domain/entity/add_product_entity.dart';

class AddProductResponse extends BaseResponse<BaseEntity> {
  AddProductData data;

  AddProductResponse({
    required super.status,
    required super.message,
    required this.data,
    required super.code,
  });

  factory AddProductResponse.fromJson(Map<String, dynamic> json) {
    log('on from json in add product response');
    log(' in add product response, code: ' + json['status_code'].toString());
    return AddProductResponse(
      status: json['status'] ?? "",
      message: json['message'] ?? "any",
      code: json['status_code'] ?? 400,
      data: AddProductData(
        productId: json['data']['id'],
        productPhotos: json['data']['photos'],
      ),
    );
  }

  @override
  AddProductEntity toEntity() {
    return AddProductEntity(
      productId: data.productId,
      productPhotos: data.productPhotos,
    );
  }
}

class AddProductData {
  final int productId;
  final List<String> productPhotos;

  AddProductData({required this.productId, required this.productPhotos});
}
