// lib/features/notifications/domain/notification_repo.dart
import 'package:Bid_Mart/core/entities/empty_entity.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/notifications/data/models/requests/request.dart';

import 'notification_enitity.dart';

abstract class NotificationRepo {
  Future<Result<AppErrors, NotificationsEntity>> getNotifications();

  Future<Result<AppErrors, EmptyEntity>> updateNotification({
    required NotificationRequest notificationRequest,
  });

  Future<Result<AppErrors, EmptyEntity>> deleteNotification({
    required NotificationRequest notificationRequest,
  });
}
