import 'dart:developer';
import 'dart:io';

import 'package:Bid_Mart/core/requests/base_request.dart';

class AddProductRequest extends BaseRequest {
  final String name, description, location, startDate, deliveryDate;

  final List<File> photos;
  final String? tabId, amount;
  final int categoryId, periodOfBid;
  final double startingPrice, expectedPrice;
  final String? address, categoryName;
  AddProductRequest({
    required this.photos,
    required this.name,
    required this.description,
    required this.location,
    required this.startDate,
    required this.deliveryDate,
    required this.categoryId,
    required this.periodOfBid,
    required this.startingPrice,
    required this.expectedPrice,
    this.address,
    this.categoryName,
    this.tabId,
    this.amount,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "location": location,
      "start_date": startDate,
      "delivery_date": deliveryDate,
      "category_id": categoryId,
      "period_of_bid": periodOfBid,
      "starting_price": startingPrice,
      "expected_price": expectedPrice,
      "TAB_ID": tabId,
      "AMOUNT": amount,
    };
  }

  List<Map<String, dynamic>> getFiles() {
    return photos
        .map<Map<String, dynamic>>(
          (imageFile) => {
            'fieldName': 'photo',
            'filePath': imageFile.path,
            'fileName': imageFile.path.split('/').last,
          },
        )
        .toList();
  }

  @override
  void printRequest() {
    log(toJson().toString());
  }

  AddProductRequest copyWith({
    String? name,
    String? description,
    String? location,
    String? startDate,
    String? deliveryDate,
    List<File>? photos,
    String? tabId,
    String? amount,
    int? categoryId,
    String? address,
    String? categoryName,
    int? periodOfBid,
    double? startingPrice,
    double? expectedPrice,
  }) {
    log("Tap id $tabId");
    return AddProductRequest(
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      photos: photos ?? this.photos,
      tabId: tabId ?? this.tabId,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      periodOfBid: periodOfBid ?? this.periodOfBid,
      startingPrice: startingPrice ?? this.startingPrice,
      expectedPrice: expectedPrice ?? this.expectedPrice,
    );
  }
}
