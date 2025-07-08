import 'dart:developer';

import 'package:peakmart/core/requests/base_request.dart';

class LoginRequest extends BaseRequest {
  final String email;
  final String password;
  final String fCMToken;
  LoginRequest({
    required this.email,
    required this.password,
    required this.fCMToken,
  });

  @override
  void printRequest() {
    log("email: $email, password: $password, fcmToken: $fCMToken");
  }

  @override
  Map<String, dynamic> toJson() {
    return {"email": email, "password": password, "FCM_token": fCMToken};
  }
}
