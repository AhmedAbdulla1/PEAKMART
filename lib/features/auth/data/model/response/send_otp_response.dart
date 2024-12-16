import 'dart:developer';

import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/features/auth/domain/entity/send_otp_entity.dart';

class SendOtpResponse extends BaseResponse {
  SendOtpData data;
  SendOtpResponse({
    required super.status,
    required super.message,
    required this.data,
    required super.code,
  });

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) {
    log('on from json');
    return SendOtpResponse(
      status: json['status'] ?? "",
      code: json['code'] ?? "",
      message: json['message'] ?? "",
      data: SendOtpData(
        email: json['data']['email'],
      ),
    );
  }

  @override
  SendOtpEntity toEntity() {
    return SendOtpEntity(
      email: data.email,
    );
  }
}

class SendOtpData {
  final String email;

  SendOtpData({required this.email});
}
