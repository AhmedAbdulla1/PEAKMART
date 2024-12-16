import 'dart:developer';

import 'package:peakmart/core/requests/base_request.dart';

class VerfiyOtpRequest extends BaseRequest {
  final String otp;
  final String email, username;
  VerfiyOtpRequest(
      {required this.email,
      required this.username,
      // required this.userId,
      required this.otp});

  @override
  void printRequest() {
    log("otp in verfiy otp request: $otp");
  }

  Map<String, String> toHeaders() {
    return {
      'Content-Type': 'application/json',
      'Cookie': 'EMAIL=$email; USER_NAME=$username'
    };
  }

  @override
  Map<String, dynamic> toJson() {
    return {"otp": otp};
  }
}
