import 'package:peakmart/core/entities/base_entity.dart';

class PaginationEntity extends BaseEntity {
  final int currentPage, totalPages, totalRecords, limitPerPage;

  const PaginationEntity({
    required this.currentPage,
    required this.totalPages,
    required this.totalRecords,
    required this.limitPerPage,
  });

  @override
  List<Object?> get props => [];
}
