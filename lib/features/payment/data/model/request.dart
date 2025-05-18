import 'dart:developer';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/requests/base_request.dart';

class ConfirmPaymentRequest extends BaseRequest {
  final double amount;
  final String reason;
  final String tapId;

  ConfirmPaymentRequest({
    required this.amount,
    required this.reason,
    required this.tapId,
  });

  @override
  void printRequest() {
    log('amount is $amount, reason is $reason, tapId is $tapId');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "USER_ID": instance<AppPreferences>().getUserId(),
      "TAB_ID": tapId,
      "REASON": reason,
      "STATUS": "CAPTURED",
      "AMOUNT": amount,
    };
  }
}