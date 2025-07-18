import 'dart:async';
import 'dart:developer';

import 'package:Bid_Mart/core/error_ui/toast.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/widgets/waiting_widget.dart';
import 'package:Bid_Mart/features/notifications/data/firebase_cloud_messaging_service.dart';
import 'package:Bid_Mart/features/notifications/data/local_notification_service.dart';
import 'package:Bid_Mart/features/notifications/domain/notification_enitity.dart';
import 'package:Bid_Mart/features/notifications/presentation/state_m/notification_cubit.dart';
import 'package:Bid_Mart/features/notifications/presentation/state_m/notification_state.dart';
import 'package:Bid_Mart/features/notifications/presentation/state_m/notifications_cubit.dart';
import 'package:Bid_Mart/features/notifications/presentation/view/notifications_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});
  static const routeName = '/notificationsView';

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final List<NotificationEntity> _apiNotifications = [];
  final List<NotificationEntity> _fcmNotifications = [];

  late final StreamSubscription<NotificationEntity> _fcmSubscription;

  @override
  void initState() {
    super.initState();

    context.read<NotificationCubit>().fetchNotifications();

    _fcmSubscription =
        FirebaseCloudMessagingService.streamController.stream.listen(
      (notificationMessage) {
        final isNotificationsActive = context.read<NotificationsCubit>().state;

        if (!isNotificationsActive) {
          Toast.show("Notifications are disabled.",
              backgroundColor: ColorManager.primary);
          return;
        }

        setState(() {
          _fcmNotifications.insert(0, notificationMessage);
          log("📥 New notification added: ${notificationMessage.title}");
        });

        LocalNotificationService.showBasicNotification(
          id: 0,
          title: notificationMessage.title,
          body: notificationMessage.description,
        );
      },
    );
  }

  @override
  void dispose() {
    _fcmSubscription.cancel();
    super.dispose();
  }

  List<NotificationEntity> get allNotifications => [
        ..._fcmNotifications,
        ..._apiNotifications.where(
          (api) => !_fcmNotifications.any((fcm) => fcm.id == api.id),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<NotificationCubit, NotificationsState>(
      listener: (context, state) {
        if (state is NotificationsLoaded) {
          setState(() {
            _apiNotifications
              ..clear()
              ..addAll(state.notifications);
          });
        } else if (state is NotificationsError) {
          Toast.show("Failed to load notifications");
        }
      },
      builder: (context, state) {
        if (state is NotificationsLoading && allNotifications.isEmpty) {
          return const WaitingWidget();
        }

        return NotificationsViewBody(
          notifications: allNotifications,
        );
      },
    );
  }
}
