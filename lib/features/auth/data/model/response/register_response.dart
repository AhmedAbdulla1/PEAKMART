import 'dart:developer';

import 'package:peakmart/core/entities/base_entity.dart';
import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/features/auth/domain/entity/register_entity.dart';

class RegisterResponse extends BaseResponse<BaseEntity> {
  RegisterData data;

  RegisterResponse({
    required super.status,
    required super.message,
    required this.data, required super.code,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    log('on from json');
    return RegisterResponse(
      status: json['status'] ?? "",
      message: json['message'] ?? "",
       code: json['status_code'] ?? 400,
      data: RegisterData(
        email: json['data']['email'],
        userId: json['data']['id'],
        userName: json['data']['name'],
        phoneNumber: json['data']['phone'],
      ),
    );
  }

  @override
  RegisterEntity toEntity() {
    return RegisterEntity(
      email: data.email,
      userId: data.userId.toString(),
      userName: data.userName,
      phoneNumber: data.phoneNumber,
    );
  }
}

class RegisterData {
  String email;
  int userId;
  String userName;
  String phoneNumber;

  RegisterData(
      {required this.email,
      required this.userId,
      required this.userName,
      required this.phoneNumber});
}
