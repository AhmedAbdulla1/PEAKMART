import 'dart:developer';

import 'package:Bid_Mart/app/app_prefs.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/requests/base_request.dart';

class OwnProductRequest extends BaseRequest {
  final int productId;
  final String amount, tapId;

  OwnProductRequest({
    required this.productId,
    required this.amount,
    required this.tapId,
  });

  @override
  void printRequest() {
    log("product Id: $productId, amount: $amount, tapId: $tapId");
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "item_id": productId,
      "user_id": instance<AppPreferences>().getCookie("HK"),
      "amount": amount,
      'tab_id': tapId
    };
  }
}
