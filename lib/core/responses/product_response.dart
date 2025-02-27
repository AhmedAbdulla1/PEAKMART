import 'dart:convert';

import 'package:peakmart/core/entities/prodcut_entity.dart';

class ProductResponse {
  final int id;
  final String name;
  final String? imageUrl;
  final String endDate;
  final int peopleRolledIn;
  final double price;
  final bool isEnded;
  final String description;

  ProductResponse({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.endDate,
    required this.peopleRolledIn,
    required this.price,
    required this.isEnded,
    required this.description,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['I_ID'] ?? 0,
      description: json['DESCRIPTION'] ?? "",
      name: json['ITEM_NAME'] ?? "",
      imageUrl: json['PHOTO'],
      endDate: json['END_DATE'] ?? "",
      peopleRolledIn: json['peopleRolledIn'] ?? 20,
      price: double.tryParse(json['STARTING_PRICE'].toString()) ?? 0.0,
      isEnded: json['STATUS'] == "not_ended" ? false : true,
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
        id: id,
        name: name,
        imageUrl: imageUrl != null && imageUrl!.isNotEmpty
            ? List<String>.from(jsonDecode(imageUrl!))
            : ["https://picsum.photos/800/600"],
        endDate: endDate,
        peopleRolledIn: peopleRolledIn,
        price: price,
        isEnded: isEnded,
        description: description);
  }
}
