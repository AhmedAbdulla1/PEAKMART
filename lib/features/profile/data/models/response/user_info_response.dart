import 'package:Bid_Mart/core/entities/base_entity.dart';
import 'package:Bid_Mart/core/models/base_model.dart';
import 'package:Bid_Mart/features/profile/domain/enitiy/user_info_entity.dart';

class UserInfoResponse extends BaseResponse<BaseEntity> {
  UserInfoData data;

  UserInfoResponse({
    required super.status,
    required super.message,
    required this.data,
    required super.code,
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) {
    final sellerInfoData = json['data']['seller_info'];
    return UserInfoResponse(
      status: json['status'] ?? "",
      message: json['message'] ?? "",
      code: json['status_code'] ?? 200,
      data: UserInfoData(
        userName: json['data']['USER_NAME'],
        email: json['data']['EMAIL'],
        phone: json['data']['PHONE'],
        photo: json['data']['PHOTO'],
        loyaltyPoint: json['data']['LOYALTY_P'] ?? 0,
        balance: json['data']['BALANCE'] ?? "0",
        sellerInfo: sellerInfoData != null
            ? sellerInfoData is String
                ? {}
                : sellerInfoData
            : {},
      ),
    );
  }

  @override
  UserInfoEntity toEntity() {
    return UserInfoEntity(
      email: data.email,
      phone: data.phone,
      photo: data.photo,
      loyaltyPoint: data.loyaltyPoint,
      sellerInfo: data.sellerInfo,
      balance: data.balance,
      userName: data.userName,
    );
  }
}

class UserInfoData {
  String email, phone, photo, userName,balance;
  Map<String, dynamic> sellerInfo;
  int loyaltyPoint;
  UserInfoData({
    required this.email,
    required this.phone,
    required this.loyaltyPoint,
    required this.balance,
    required this.photo,
    required this.sellerInfo,
    required this.userName,
  });
}
