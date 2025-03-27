import 'dart:convert';

import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/core/responses/pagination_response.dart';
import 'package:peakmart/features/home/domain/entity/category_entity.dart';
import 'package:peakmart/features/home/domain/entity/content_entity.dart';

class CategoriesResponse extends BaseResponse<CategoriesEntity> {
  final List<CategoryDataResponse>? data;

  CategoriesResponse({
    required this.data,
    required super.status,
    required super.message,
    required super.code,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesResponse(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: List<CategoryDataResponse>.from(
            json["data"].map((x) => CategoryDataResponse.fromJson(x))),
      );

  @override
  CategoriesEntity toEntity() {
    return CategoriesEntity(
      categories: data!.map((e) => e.toEntity()).toList(),
    );
  }
}

class CategoryDataResponse {
  int? catId;
  String? catName;
  String? image;

  CategoryDataResponse(
      {
  this.catId,
  this.catName,
  this.image,
  });

  factory CategoryDataResponse.fromJson(Map<String, dynamic> json) {
    return CategoryDataResponse(
      catId: json["CAT_ID"],
      catName: json["CAT_NAME"],
      image: json["IMG"],
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      catId: catId ?? 0,
      catName: catName ?? "",
      image: image ?? "",
    );
  }
}

extension StringExtension on String? {
  SectionName toSectionName() {
    switch (this) {
      case "Cover":
        return SectionName.Cover;
      case "Ads":
        return SectionName.Ads;
      case "Apply":
        return SectionName.Apply;
      case "Parteners":
        return SectionName.Parteners;
      default:
        return SectionName.Cover;
    }
  }
}
