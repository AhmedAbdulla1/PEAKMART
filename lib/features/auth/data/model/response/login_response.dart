import 'dart:developer';

import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/core/entities/base_entity.dart';
import 'package:peakmart/features/auth/domain/entity/login_entity.dart';

class LoginResponse extends BaseResponse<BaseEntity> {
  LoginData data;

  LoginResponse({
    required super.status,
    required super.message,
    required this.data, required super.code,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    log('on from json');
    return LoginResponse(
      status: json['status']??"",
      message: json['message']??"",
      code: json['code']??200,
      data: LoginData(
        email: json['data']['EMAIL'],
        userId: json['data']['USER_ID'],
        userName: json['data']['USER_NAME'],
      ),
    );
  }

  @override
  LoginEntity toEntity() {
    return LoginEntity(
      email: data.email,
      userId: data.userId.toString(),
      userName: data.userName,
    );
  }
}

class LoginData {
  String email;
  int userId;
  String userName;

  LoginData({
    required this.email,
    required this.userId,
    required this.userName,
  });
}
