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
    return AddProductResponse(
      status: json['status'] ?? "",
      message: json['message'] ?? "",
      code: json['status_code'] ?? 400,
      data: AddProductData(
        productId: json['data']['id'],
        productName: json['data']['name'],
        description: json['data']['description'],
        photoUrl: json['data']['photo_url'],
        location: json['data']['location'],
        startDate: json['data']['start_date'],
        deliveryDate: json['data']['delivery_date'],
        categoryId: json['data']['category_id'],
        periodOfBid: json['data']['period_of_bid'],
        startingPrice: json['data']['starting_price'],
        expectedPrice: json['data']['expected_price'],
      ),
    );
  }

  @override
  AddProductEntity toEntity() {
    return  AddProductEntity(
      productId: data.productId,
      productName: data.productName,
      description: data.description,
      photoUrl: data.photoUrl,
      location: data.location,
      startDate: data.startDate,
      deliveryDate: data.deliveryDate,
      categoryId: data.categoryId,
      periodOfBid: data.periodOfBid,
      startingPrice: data.startingPrice,
      expectedPrice: data.expectedPrice
    );
  }
}

class AddProductData {
  final int productId, categoryId, startingPrice, expectedPrice, periodOfBid;
  final String productName,
      description,
      photoUrl,
      location,
      startDate,
      deliveryDate;

  AddProductData(
      {required this.productId,
      required this.categoryId,
      required this.startingPrice,
      required this.expectedPrice,
      required this.periodOfBid,
      required this.productName,
      required this.description,
      required this.photoUrl,
      required this.location,
      required this.startDate,
      required this.deliveryDate});
}
