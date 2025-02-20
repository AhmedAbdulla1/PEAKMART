// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:peakmart/core/requests/base_request.dart';

class AddProductRequest extends BaseRequest {
  final String photo, name, description, location, startDate, deliveryDate;
  final int categoryId, periodOfBid;
  final double startingPrice, expectedPrice;

  AddProductRequest(
      {required this.photo,
      required this.name,
      required this.description,
      required this.location,
      required this.startDate,
      required this.deliveryDate,
      required this.categoryId,
      required this.periodOfBid,
      required this.startingPrice,
      required this.expectedPrice});

  @override
  void printRequest() {
    log("""Add product request: ProductPhoto:$photo
    Name: $name
    Description: $description
    Location: $location
    Start Date: $startDate
    Delivery Date: $deliveryDate
    Category Id: $categoryId
    Period of Bid: $periodOfBid
    Starting Price: $startingPrice
    Expected Price: $expectedPrice""");
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "photo": photo,
      "name": name,
      "description": description,
      "location": location,
      "start_date": startDate,
      "delivery_date": deliveryDate,
      "category_id": categoryId,
      "period_of_bid": periodOfBid,
      "starting_price": startingPrice,
      "expected_price": expectedPrice
    };
  }
}
