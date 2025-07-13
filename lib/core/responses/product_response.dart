import 'dart:convert';

import 'package:Bid_Mart/core/entities/prodcut_entity.dart';

class ProductResponse {
  final int id;
  final String name;
  final List<String> imageUrl;
  final String? endDate, status;
  final String? startingPrice, expectedPrice, startDate, createdAt;
  final int? peopleRolledIn, periodOfBid, catId, userId;
  final double price;
  final bool isEnded;
  final String description;

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    final photos = List<String>.from(jsonDecode(json['PHOTO']));

    return ProductResponse(
      id: json['I_ID'] ?? 0,
      name: json['ITEM_NAME'] ?? "",
      description: json['DESCRIPTION'] ?? "",
      imageUrl: photos,
      startingPrice: json['STARTING_PRICE'] ?? "",
      expectedPrice: json['EXPECTED_PRICE'] ?? "",
      startDate: json['START_DATE'] ?? "",
      periodOfBid: json['PERIOD_OF_BID'] ?? 0,
      status: json['STATUS'] ?? "",
      catId: json['CAT_ID'] ?? 0,
      userId: json['POST_BY'] ?? 0,
      createdAt: json['CREATED_AT'] ?? "",
      endDate: json['END_DATE'] ?? "",
      peopleRolledIn: json['peopleRolledIn'] ?? 0,
      price: double.tryParse(json['STARTING_PRICE'].toString()) ?? 0.0,
      isEnded: json['STATUS'] == "not_ended" ? false : true,
    );
  }

  ProductResponse(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.endDate,
      required this.status,
      required this.startingPrice,
      required this.expectedPrice,
      required this.startDate,
      required this.createdAt,
      required this.peopleRolledIn,
      required this.periodOfBid,
      required this.catId,
      required this.userId,
      required this.price,
      required this.isEnded,
      required this.description});

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      imageUrl: imageUrl.isNotEmpty
          ? imageUrl
          : ["https://hk.herova.net/assets/img/product.png"],
      endDate: endDate,
      status: status,
      startingPrice: startingPrice,
      expectedPrice: expectedPrice,
      startDate: startDate,
      createdAt: createdAt,
      peopleRolledIn: peopleRolledIn,
      periodOfBid: periodOfBid,
      catId: catId,
      userId: userId,
      price: price,
      isEnded: isEnded,
      description: description,
    );
  }
}
