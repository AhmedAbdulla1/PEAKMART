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

  Future<FormData> toFormData() async {
    List<MultipartFile> imageFiles = await Future.wait(
      photos.map((file) async => await MultipartFile.fromFile(file.path)),
    );

    return FormData.fromMap({
      "photo": imageFiles,
      "name": name,
      "description": description,
      "location": location,
      "start_date": startDate,
      "delivery_date": deliveryDate,
      "category_id": categoryId,
      "period_of_bid": periodOfBid,
      "starting_price": startingPrice,
      "expected_price": expectedPrice,
    });
  }
}
