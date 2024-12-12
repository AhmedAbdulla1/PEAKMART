import 'dart:developer';

import 'package:peakmart/app/base_request.dart';

class LoginRequest extends BaseRequest {

  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  @override
  void printRequest() {
    log("email: $email, password: $password");
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password
    };
  }
}