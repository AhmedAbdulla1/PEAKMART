import 'dart:developer';

import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/requests/base_request.dart';

class BidRequest extends BaseRequest {
  final String productId;
  final String amount;

  BidRequest(
      {required this.productId, required this.amount})
      : super();

  @override
  void printRequest() {
    log(toJson().toString(),name: "bid request");
  }

  @override
  Map<String, dynamic> toJson() {
    String userId = instance<AppPreferences>().getUserId();

    return {
      "BID_AMOUNT": amount,
      "I_ID": productId,
      "BIDDER_ID": userId,
    };
  }
}