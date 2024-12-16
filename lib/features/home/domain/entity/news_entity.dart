import 'package:peakmart/core/entities/base_entity.dart';
import 'package:peakmart/core/entities/pagination_entity.dart';

class NewsEntity extends BaseEntity {
  final List<NewsData> news;
  final PaginationEntity pagination;
  const NewsEntity({required this.news , required this.pagination});

  @override
  List<Object?> get props => news;
}

class NewsData {
  final String active, content, link;
  final int id;

  const NewsData({
    required this.active,
    required this.id,
    required this.content,
    required this.link,
  });
}
