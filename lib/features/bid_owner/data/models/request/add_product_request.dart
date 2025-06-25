import 'dart:developer';
import 'dart:io';

import 'package:peakmart/core/requests/base_request.dart';

class AddProductRequest extends BaseRequest {
  final String name,
      description,
      location,
      startDate,
      deliveryDate,
      tabId,
      amount;
  final List<File> photos;
  final int categoryId, periodOfBid;
  final double startingPrice, expectedPrice;

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
    required this.tabId,
    required this.amount,
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
}
