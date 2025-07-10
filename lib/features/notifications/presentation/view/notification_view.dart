import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/error_ui/toast.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/notifications/data/firebase_cloud_messaging_service.dart';
import 'package:peakmart/features/notifications/domain/notification_enitity.dart';
import 'package:peakmart/features/notifications/presentation/state_m/notification_cubit.dart';
import 'package:peakmart/features/notifications/presentation/state_m/notification_state.dart';
import 'package:peakmart/features/notifications/presentation/state_m/notifications_cubit.dart';
import 'package:peakmart/features/notifications/presentation/view/notifications_view_body.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});
  static const routeName = '/notificationsView';

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  List<NotificationEntity> notifications = [];

  void listenNotificationStream() {
    FirebaseCloudMessagingService.streamController.stream.listen(
      (notificationMessage) async {
        final isNotificationsActive = context.read<NotificationsCubit>().state;
        if (!isNotificationsActive) {
          if (mounted) {
            Toast.show("Notifications are disabled.",
                backgroundColor: ColorManager.primary);
          }
          return;
        }

        log('Notification Received: ${notificationMessage.notification?.body}');

        setState(() {
          notifications.add(notificationMessage);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<NotificationCubit>().fetchNotifications();

    return BlocConsumer<NotificationCubit, NotificationsState>(
      listener: (context, state) {
        if (state is NotificationsError) {
          Toast.show("Failed to load notifications");
        }
        if (state is NotificationsLoaded) {
          log("Unseen Count in listener: ${state.unseenCount}");
        }
      },
      builder: (context, state) {
        if (state is NotificationsLoading) {
          return const WaitingWidget();
        } else if (state is NotificationsLoaded) {
          notifications = state.notifications;
          log("In Notification View Notifications list: $notifications");
          return NotificationsViewBody(notifications: state.notifications);
        } else if (state is NotificationsError) {
          return const Center(child: const Text("Something went wrong 😢"));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
