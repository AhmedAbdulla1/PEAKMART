import 'dart:developer';

import 'package:peakmart/core/requests/base_request.dart';

class SendOtpRequest extends BaseRequest {
  final String key; 

  SendOtpRequest({required this.key});

  @override
  void printRequest() {
    log("key in send otp request: $key");
  }

  @override
  Map<String, dynamic> toJson() {
    return {"key": key};
  }
}
