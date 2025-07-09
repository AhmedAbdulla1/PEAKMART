import 'dart:developer';

import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/requests/base_request.dart';

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