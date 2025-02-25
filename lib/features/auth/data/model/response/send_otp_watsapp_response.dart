import 'dart:developer';

import 'package:peakmart/core/entities/base_entity.dart';
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/features/auth/domain/entity/send_otp_entity.dart';

class WatsAppOtpResponse extends BaseResponse {
  String? error;

  WatsAppOtpResponse({
    required super.status,
    required super.message,
    required this.error,
    required super.code,
  });

  factory WatsAppOtpResponse.fromJson(Map<String, dynamic> json) {
    log('on from json');
    return WatsAppOtpResponse(
      status: json['status'] ?? "",
      code: json['status_code'] ?? 400,
      message: json['message'] ?? "",
      error: json['error'],
    );
  }

  @override
  EmptyEntity toEntity() {
    return EmptyEntity(
        message: error != null ? error! : message, code: code, status: status);
  }
}

class SendOtpData {
  final String email;

  SendOtpData({required this.email});
}
