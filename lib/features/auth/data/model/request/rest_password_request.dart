import 'dart:developer';

import 'package:peakmart/core/requests/base_request.dart';


class RestPasswordRequest extends BaseRequest {
  final String email;

  RestPasswordRequest({required this.email});

  @override
  void printRequest() {
    log("email: $email");
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "email": email,
    };
  }
}