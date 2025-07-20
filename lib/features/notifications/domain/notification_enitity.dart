// lib/features/notifications/domain/entity/notification_entity.dart
import 'package:Bid_Mart/core/entities/base_entity.dart';

class NotificationEntity extends BaseEntity {
  final int id;
  final String title;
  final String? icon;
  final int userId;
  final String description;
 final String seen;
  final String? url;
  final String createdAt;
  final String routeName;
  final int arg ;

  const NotificationEntity({
    required this.id,
    required this.title,
    this.icon,
    required this.userId,
    required this.description,
    required this.seen,
    this.url,
    required this.createdAt,
    required this.arg,
    required this.routeName,
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
