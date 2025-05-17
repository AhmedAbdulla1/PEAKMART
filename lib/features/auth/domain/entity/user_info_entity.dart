import 'package:peakmart/core/entities/base_entity.dart';

class UserInfoEntity extends BaseEntity {
  final String userName, phone, photo, sellerInfo, email;

  const UserInfoEntity(
      {required this.userName,
      required this.phone,
      required this.photo,
      required this.sellerInfo,
      required this.email});

  @override
  List<Object?> get props => [email, userName, phone, photo, sellerInfo];
}
