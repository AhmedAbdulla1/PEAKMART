import 'dart:developer';

import 'package:peakmart/core/requests/base_request.dart';

class SendOtpRequest extends BaseRequest {
  final String key;
  final String email, username, userId;

  SendOtpRequest(
      {required this.key,
      required this.email,
      required this.username,
      required this.userId});

  @override
  void printRequest() {
    log("key in send otp request: $key");
  }

  Map<String, String> toHeaders() {
    return {
      'Content-Type': 'application/json',
      'Cookie': 'EMAIL=$email; USER_ID=$userId; USER_NAME=$username'
    };
  }

  @override
  Map<String, dynamic> toJson() {
    return {"key": key};
  }
}
