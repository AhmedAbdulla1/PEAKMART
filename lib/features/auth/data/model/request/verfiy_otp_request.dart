import 'dart:developer';

import 'package:Bid_Mart/core/requests/base_request.dart';

import '../../../../notifications/data/firebase_cloud_messaging_service.dart';

class VerfiyOtpRequest extends BaseRequest {
  final String otp;
  final String email, username;
  VerfiyOtpRequest(
      {required this.email,
      required this.username, required this.otp});

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
  final String? fCMToken = FirebaseCloudMessagingService.token;

  @override
  Map<String, dynamic> toJson() {
    return {"otp": otp, "FCM_token": fCMToken};
  }
}
