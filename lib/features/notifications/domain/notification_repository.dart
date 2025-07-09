// lib/features/notifications/domain/notification_repo.dart
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/notifications/data/models/requests/request.dart';

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
