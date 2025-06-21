import 'dart:io';

import 'package:dio/dio.dart';

class AddProductRequest {
  final String name, description, location, startDate, deliveryDate;
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
  });

  Map<String, dynamic> toFormData() {
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
    };
  }

  List<Map<String, dynamic>> getFiles() {
    return photos
        .map<Map<String, dynamic>>(
          (imageFile) => {
            'fieldName':'photo',
            'filePath': imageFile.path,
            'fileName': imageFile.path.split('/').last,
          },
        )
        .toList();
  }
}
