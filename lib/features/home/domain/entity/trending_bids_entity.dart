import 'package:peakmart/core/entities/base_entity.dart';

class TrendingBidsEntity extends BaseEntity {
  final List<TrendingBidsData> data;

  const TrendingBidsEntity({required this.data});

  @override
  List<Object?> get props => data;
}

class TrendingBidsData {
  final String itemName, description, startDate, status;
  final String? itemImage;
  const TrendingBidsData(
      {required this.itemName,
      required this.description,
      this.itemImage,
      required this.startDate,
      required this.status});
}
