import 'package:Bid_Mart/core/models/base_model.dart';
import 'package:Bid_Mart/features/notifications/domain/notification_enitity.dart';

class NotificationsResponse extends BaseResponse<NotificationsEntity> {
  final List<NotificationResponse> notifications;

  final int unseenCount;

  NotificationsResponse(
      {required this.unseenCount,
      required this.notifications,
      required super.message,
      required super.status,
      required super.code});

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['notifications'] ?? [];
    List<NotificationResponse> notificationList;
    if (rawData is List) {
      notificationList =
          rawData.map((e) => NotificationResponse.fromJson(e)).toList();
    } else {
      notificationList = [];
    }

    return NotificationsResponse(
        unseenCount: json['unseen_count'] ?? 0,
        notifications: notificationList,
        message: json['message'] ?? "",
        status: json['status'] ?? "",
        code: json['code'] ?? 0);
  }

  @override
  NotificationsEntity toEntity() {
    return NotificationsEntity(
      notifications: notifications.map((element) {
        return element.toEntity();
      }).toList(),
      unseenCount: unseenCount,
    );
  }
}

class NotificationResponse {
  final int id;
  final String title;
  final String? icon;
  final int userId;
  final String description;
  String seen;
  final String? url;
  final String createdAt;

  NotificationResponse({
    required this.id,
    required this.title,
    this.icon,
    required this.userId,
    required this.description,
    required this.seen,
    this.url,
    required this.createdAt,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      userId: json['user_id'],
      description: json['description'],
      seen: json['seen'],
      url: json['url'],
      createdAt: json['created_at'],
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
        createdAt: createdAt,
        description: description,
        id: id,
        seen: seen,
        title: title,
        userId: userId,
        icon: icon,
        url: url);
  }
}
