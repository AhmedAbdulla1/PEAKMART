import 'dart:developer';

import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/requests/base_request.dart';

class EnrollRequest extends BaseRequest {
  final String productId;
  final String tapId;
  final String fees;

  EnrollRequest(
      {required this.productId, required this.tapId, required this.fees})
      : super();

  @override
  void printRequest() {
    log(toJson().toString(),name: 'EnrollRequest');
  }

  @override
  Map<String, dynamic> toJson() {
    String userId = instance<AppPreferences>().getUserId();

    return {
      "fees": fees,
      "product_id": productId,
      "tap_id": tapId,
      "user_id": userId,
    };
  }
}
