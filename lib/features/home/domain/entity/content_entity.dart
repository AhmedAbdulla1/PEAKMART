import 'package:peakmart/core/entities/base_entity.dart';
import 'package:peakmart/core/entities/pagination_entity.dart';

class ContentEntity extends BaseEntity {
  final List<ContentData> data;
  final PaginationEntity pagination;

  const ContentEntity({
    required this.data,
    required this.pagination,
  });

  @override
  List<Object?> get props => [data, pagination];
}

class ContentData {
  final int id;
  final SectionName sectionName;
  final String content;
  final Map<String,dynamic> image;
  final String? subTitle;
  final String? subContent;
  final String? subHead;

  ContentData({
    required this.id,
    required this.sectionName,
    required this.content,
    required this.image,
    required this.subTitle,
    required this.subContent,
    required this.subHead,
  });
}

enum SectionName { Cover, Ads, Apply, Parteners }
