import 'dart:convert';

import 'package:peakmart/features/profile/domain/enitiy/product_enrolled_entity.dart';

class ProductsEnrolledResponse {
  final num id, fees, highestBid, userBid;
  final String itemName, endDate;
  final List<String> imageUrl;

  final bool owned, endStatus, enrollmentStatus, winnerStatus;

  ProductsEnrolledResponse(
      {required this.id,
      required this.itemName,
      required this.endDate,
      required this.fees,
      required this.highestBid,
      required this.userBid,
      required this.imageUrl,
      required this.owned,
      required this.endStatus,
      required this.enrollmentStatus,
      required this.winnerStatus});

  factory ProductsEnrolledResponse.fromJson(Map<String, dynamic> json) {
    final photo = List<String>.from(jsonDecode(json['PHOTO']));

    return ProductsEnrolledResponse(
      id: json['I_ID'] ?? 0,
      itemName: json['ITEM_NAME'] ?? "",
      endDate: json['end_date'] ?? "",
      fees: json['fees'] ?? "",
      highestBid: json['highestBid'] ?? "",
      userBid: json['userBid'] ?? "",
      imageUrl: photo,
      owned: json['Owned'] == "not_ended" ? false : true,
      endStatus: json['status'] == "not_ended" ? false : true,
      enrollmentStatus: json['enrollmentStatus'] == "not_ended" ? false : true,
      winnerStatus: json['winnerStatus'],
    );
  }

  ProductsEnrolledEntity toEntity() {
    return ProductsEnrolledEntity(
      id: id,
      itemName: itemName,
      endDate: endDate,
      fees: fees,
      highestBid: highestBid,
      userBid: userBid,
      imageUrl: imageUrl,
      owned: owned,
      endStatus: endStatus,
      enrollmentStatus: enrollmentStatus,
      winnerStatus: winnerStatus,
    );
  }
}
