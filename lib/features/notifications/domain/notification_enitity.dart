// lib/features/notifications/domain/entity/notification_entity.dart
import 'package:peakmart/core/entities/base_entity.dart';

class NotificationEntity extends BaseEntity {
  final int id;
  final String title;
  final String? icon;
  final int userId;
  final String description;
  bool seen;
  final String? url;
  final String createdAt;

  NotificationEntity({
    required this.id,
    required this.title,
    this.icon,
    required this.userId,
    required this.description,
    required this.seen,
    this.url,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}

class NotificationsEntity extends BaseEntity {
  final List<NotificationEntity> notifications;
  final int unseenCount;

  const NotificationsEntity({
    required this.notifications,
    required this.unseenCount,
  });

  @override
  List<Object?> get props => [notifications, unseenCount];
}
