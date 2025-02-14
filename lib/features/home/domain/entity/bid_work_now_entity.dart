import 'package:peakmart/core/entities/base_entity.dart';

class BidWorkNowEntity extends BaseEntity {
  final List<BidWorkNowData> data;

  const BidWorkNowEntity({required this.data});

  @override
  List<Object?> get props => data;
}

class BidWorkNowData {
  final String itemName, description, startDate, status;
  final String? itemImage;
  const BidWorkNowData(
      {required this.itemName,
      required this.description,
      this.itemImage,
      required this.startDate,
      required this.status});
}
