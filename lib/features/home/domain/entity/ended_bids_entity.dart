import 'package:peakmart/core/entities/base_entity.dart';

class EndedBidsEntity extends BaseEntity {
  final List<EndedBidsData> data;

  const EndedBidsEntity({required this.data});

  @override
  List<Object?> get props => data;
}

class EndedBidsData {
  final String itemName, description, startDate, status;
  final String? itemImage;
  const EndedBidsData(
      {required this.itemName,
      required this.description,
      this.itemImage,
      required this.startDate,
      required this.status});
}
