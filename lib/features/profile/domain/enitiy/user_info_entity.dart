import 'package:peakmart/core/entities/base_entity.dart';

class UserInfoEntity extends BaseEntity {
  final String userName, phone, photo, sellerInfo, email;
  final int loyaltyPoint;
  const UserInfoEntity(
      {required this.userName,
      required this.phone,
      required this.photo,
      required this.sellerInfo,
        required this.loyaltyPoint,
      required this.email});

  @override
  List<Object?> get props => [email, userName, phone, photo, sellerInfo,loyaltyPoint];
}
