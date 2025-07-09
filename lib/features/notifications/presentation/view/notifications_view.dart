import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/profile/presentation/views/settings/notification_switch_widget.dart';

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final NotificationType type;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
  });
}

enum NotificationType {
  won,
  ended,
  priceUpdated,
  trending,
}

class NotificationsView extends StatelessWidget {
  NotificationsView({super.key, required this.message});
  final RemoteMessage message;
  static const routeName = '/notificationsView';
  IconData _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.won:
        return Icons.emoji_events;
      case NotificationType.ended:
        return Icons.alarm_off;
      case NotificationType.priceUpdated:
        return Icons.attach_money;
      case NotificationType.trending:
        return Icons.local_fire_department;
    }
  }

  Color _getColor(NotificationType type) {
    switch (type) {
      case NotificationType.won:
        return Colors.green;
      case NotificationType.ended:
        return Colors.grey;
      case NotificationType.priceUpdated:
        return Colors.blue;
      case NotificationType.trending:
        return Colors.orange;
    }
  }

  final List<NotificationItem> notifications = [
    NotificationItem(
      title: "Congratulations! You won",
      message: "You won the auction for MacBook Pro M3 - \$2,450",
      time: "1 hour ago",
      type: NotificationType.won,
    ),
    NotificationItem(
      title: "Auction ended",
      message: "Samsung Galaxy S24 auction ended without a winner",
      time: "2 hours ago",
      type: NotificationType.ended,
    ),
    NotificationItem(
      title: "Price updated",
      message: "Tesla Model Y starting bid reduced to \$45,000",
      time: "3 hours ago",
      type: NotificationType.priceUpdated,
    ),
    NotificationItem(
      title: "New trending product added",
      message: "Limited edition Nike Air Jordan 1 is gaining attention",
      time: "4 hours ago",
      type: NotificationType.trending,
    ),
    NotificationItem(
      title: "Congratulations! You won",
      message: "You won the auction for Vintage Guitar - \$850",
      time: "1 day ago",
      type: NotificationType.won,
    ),
    NotificationItem(
      title: "Price updated",
      message: "Canon EOS R5 current bid: \$2,100 (+\$200)",
      time: "1 day ago",
      type: NotificationType.priceUpdated,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.notifications,
        isNotShowArrowBack: true,
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: NotificationSwitchIconOnly(),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.isDarkMode ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: _getColor(item.type).withOpacity(0.1),
                  child: Icon(
                    _getIcon(item.type),
                    color: _getColor(item.type),
                  ),
                ),
                12.hGap,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: getBoldStyle(fontSize: FontSize.s17),
                      ),
                      6.vGap,
                      Text(
                        item.message,
                        style: getRegularStyle(fontSize: FontSize.s14),
                      ),
                      8.vGap,
                      Text(
                        item.time,
                        style: getRegularStyle(fontSize: FontSize.s12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
