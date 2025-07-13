import 'package:Bid_Mart/core/entities/base_entity.dart';

class UserInfoEntity extends BaseEntity {
  final String userName, phone, photo,  email,balance;
  final Map<String, dynamic> sellerInfo;
  final int loyaltyPoint;

  const UserInfoEntity({
    required this.userName,
    required this.phone,
    required this.photo,
    required this.sellerInfo,
    required this.loyaltyPoint,
    required this.email,
    required this.balance,
  });

  @override
  List<Object?> get props =>
      [email, userName, phone, photo, sellerInfo, loyaltyPoint, balance];

  // Add copyWith method
  UserInfoEntity copyWith({
    String? userName,
    String? phone,
    String? photo,
    Map<String, dynamic>? sellerInfo,
    String? balance,
    int? loyaltyPoint,
    String? email,
  }) {
    return UserInfoEntity(
      userName: userName ?? this.userName,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      sellerInfo: sellerInfo ?? this.sellerInfo,
      loyaltyPoint: loyaltyPoint ?? this.loyaltyPoint,
      email: email ?? this.email,
      balance: balance?? this.balance,
    );
  }
}
