import 'package:peakmart/core/entities/base_entity.dart';

class TopBiddersEntity extends BaseEntity {
  final List<TopBiddersData> data;
  const TopBiddersEntity({required this.data});

  @override
  List<Object?> get props => data;
}

class TopBiddersData {
  final String userName, userPhoto;
  final int bidderId, bidAmount, productId;
  const TopBiddersData({
    required this.userName,
    required this.userPhoto,
    required this.bidderId,
    required this.bidAmount,
    required this.productId,

  });
}
