import 'dart:developer';

import 'package:peakmart/core/requests/base_request.dart';


class SignupForBidRequest extends BaseRequest {
  final String userName;
  final String phoneNumber;
  final String email;
  final String password;

  SignupForBidRequest(
      {required this.userName,required this.phoneNumber,required this.email, required this.password});

  @override
  void printRequest() {
    log("email: $email, password: $password, userName: $userName, phoneNumber: $phoneNumber");
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": userName,
      "email": email,
      "phone": phoneNumber,
      "password": password
    };
  }
}
