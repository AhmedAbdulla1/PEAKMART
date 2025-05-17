import 'package:peakmart/core/entities/base_entity.dart';

class TopBiddersEntity extends BaseEntity {
  final List<TopBiddersData> data;
  final int totalEnrolled, totalBidders;
  final bool userStatus;

  const TopBiddersEntity(
      {required this.data,
      required this.totalEnrolled,
      required this.totalBidders,
      required this.userStatus});

  @override
  List<Object?> get props => data;
}

class TopBiddersData {
  final String userName, userPhoto;
  final int productId;
  final double bidderId, bidAmount;
  const TopBiddersData({
    required this.userName,
    required this.userPhoto,
    required this.bidderId,
    required this.bidAmount,
    required this.productId,
  });
}
