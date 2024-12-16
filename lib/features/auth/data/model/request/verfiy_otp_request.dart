import 'dart:developer';

import 'package:peakmart/core/requests/base_request.dart';

class VerfiyOtpRequest extends BaseRequest {
  final String otp; 

  VerfiyOtpRequest({required this.otp});

  @override
  void printRequest() {
    log("key in send otp request: $otp");
  }

  @override
  Map<String, dynamic> toJson() {
    return {"otp": otp};
  }
}
