import 'dart:developer';

import 'package:Bid_Mart/app/app_prefs.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/requests/base_request.dart';

class NotificationRequest extends BaseRequest {
  final int notificationId;
  late final String userId;

  NotificationRequest({required this.notificationId}) {
    AppPreferences appPreferences = instance<AppPreferences>();
    userId = appPreferences.getUserId();
  }

  @override
  void printRequest() {
    log('notification $notificationId');
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'notification_id': notificationId
      };


}