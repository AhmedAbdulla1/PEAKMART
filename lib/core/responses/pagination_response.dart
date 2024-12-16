import 'package:peakmart/core/entities/pagination_entity.dart';

class PaginationResponse {
  PaginationResponse({
    required this.totalPages,
    required this.currentPage,
    required this.limitPerPage,
    required this.totalRecords,
  });

  final int totalPages, currentPage, limitPerPage, totalRecords;

  factory PaginationResponse.fromJson(Map<String, dynamic> json) {
    return PaginationResponse(
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      limitPerPage: json['limit_per_page'],
      totalRecords: json['total_records'],
    );
  }

  PaginationEntity toEntity() {
    return PaginationEntity(
      totalPages: totalPages,
      currentPage: currentPage,
      limitPerPage: limitPerPage,
      totalRecords: totalRecords,
    );
  }
}
