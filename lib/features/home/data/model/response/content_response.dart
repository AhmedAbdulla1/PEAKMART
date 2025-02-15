import 'dart:convert';

import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/core/responses/pagination_response.dart';
import 'package:peakmart/features/home/domain/entity/content_entity.dart';

class ContentResponse extends BaseResponse<ContentEntity> {
  final List<ContentDataResponse>? data;
  final PaginationResponse paginationResponse;

  ContentResponse({
    required this.data,
    required this.paginationResponse,
    required super.status,
    required super.message,
    required super.code,
  });

  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      ContentResponse(
        status: json["status"],
        message: json["message"],
        code: 00,
        data: List<ContentDataResponse>.from(
            json["data"].map((x) => ContentDataResponse.fromJson(x))),
        paginationResponse: PaginationResponse.fromJson(json["pagination"]),
      );

  @override
  ContentEntity toEntity() {
    return ContentEntity(
      pagination: paginationResponse.toEntity(),
      data: data!.map((e) => e.toEntity()).toList(),
    );
  }
}

class ContentDataResponse {
  int? id;
  String? sectionName;
  String? content;
  String? image;
  String? subTitle;
  String? subContent;
  String? subHead;

  ContentDataResponse(
      {this.id,
      this.sectionName,
      this.content,
      this.image,
      this.subTitle,
      this.subContent,
      this.subHead});

  factory ContentDataResponse.fromJson(Map<String, dynamic> json){
    String incorrectJson = json["IMAGE"].toString();
    // Fixing the incorrect format
    String fixedJson  = incorrectJson
        .replaceAll("[", "{")  // Replace [ with {
        .replaceAll("]", "}"); // Replace ] with }

    return ContentDataResponse(
        id: json["ID"],
        sectionName: json["SECTION_NAME"],
        content: json["CONTENT"],
        image: fixedJson,
        subTitle: json["SUB_TITLE"],
        subContent: json["SUB_CONTENT"],
        subHead: json["SUB_HEAD"],
      );}

  ContentData toEntity() {
    return ContentData(
      id: id ?? 0,
      sectionName: sectionName.toSectionName(),
      content: content??"",
      image: jsonDecode(image!),
      subTitle: subTitle,
      subContent: subContent,
      subHead: subHead,
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
