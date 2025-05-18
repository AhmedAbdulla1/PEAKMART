import 'package:peakmart/core/entities/base_entity.dart';

class ProductsEnrolledEntity extends BaseEntity {
  final num id, fees, highestBid, userBid;
  final String itemName, endDate;
  final List<String> imageUrl;

  final bool owned, endStatus, enrollmentStatus, winnerStatus;

  const ProductsEnrolledEntity(
      {required this.id,
      required this.itemName,
      required this.endDate,
      required this.fees,
      required this.highestBid,
      required this.userBid,
      required this.imageUrl,
      required this.owned,
      required this.endStatus,
      required this.enrollmentStatus,
      required this.winnerStatus});

  @override
  List<Object?> get props => [
        id,
        itemName,
        endDate,
        fees,
        highestBid,
        userBid,
        imageUrl,
        owned,
        endStatus,
        enrollmentStatus,
        winnerStatus
      ];
}
