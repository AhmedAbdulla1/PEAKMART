import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/core/responses/pagination_response.dart';
import 'package:peakmart/features/home/domain/entity/news_entity.dart';

class NewsResponse extends BaseResponse<NewsEntity> {
  final List<NewsDataResponse> data;
  final PaginationResponse paginationResponse;

  NewsResponse(
      {required this.data,
      required this.paginationResponse,
      required super.message,
      required super.status,
      required super.code});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      data: List<NewsDataResponse>.from(
          json["data"].map((newsData) => NewsDataResponse.fromJson(newsData))),
      paginationResponse: PaginationResponse(
          totalPages: 12, currentPage: 12, limitPerPage: 12, totalRecords: 14),
      message: json["message"],
      status: json["status"],
      code: 200,
    );
  }

  @override
  NewsEntity toEntity() {
    return NewsEntity(
      news: data.map((newsData) => newsData.toEntity()).toList(),
      pagination: paginationResponse.toEntity(),
    );
  }
}

class NewsDataResponse {
  String active;
  String content;
  int id;
  String link;

  NewsDataResponse({
    required this.active,
    required this.content,
    required this.id,
    required this.link,
  });

  factory NewsDataResponse.fromJson(Map<String, dynamic> json) {
    return NewsDataResponse(
      active: json["ACTIVE"],
      content: json["CONTENT"],
      id: json["NEWS_ID"],
      link: json["LINK"],
    );
  }

  NewsData toEntity() {
    return NewsData(
      active: active,
      content: content,
      id: id,
      link: link,
    );
  }
}
