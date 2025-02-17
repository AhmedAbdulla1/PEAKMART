import 'package:peakmart/core/entities/base_entity.dart';

class FutureBidsEntity extends BaseEntity {
  final List<FutureBidsData> data;

  const FutureBidsEntity({required this.data});

  @override
  List<Object?> get props => data;
}

class FutureBidsData {
  final String itemName, description, startDate, status;
  final String? itemImage;
  const FutureBidsData(
      {required this.itemName,
      required this.description,
      this.itemImage,
      required this.startDate,
      required this.status});
}
