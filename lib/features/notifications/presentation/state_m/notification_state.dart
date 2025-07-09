// lib/features/notifications/presentation/state_m/notification_state.dart
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/features/notifications/domain/notification_enitity.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationsLoaded extends NotificationState {
  final List<NotificationEntity> notifications;
  final int unseenCount;

  NotificationsLoaded({
    required this.notifications,
    required this.unseenCount,
  });
}

class NotificationActionSuccess extends NotificationState {
  final String message;

  NotificationActionSuccess({required this.message});
}

class NotificationError extends NotificationState {
  final CustomError error;
  final Function()? onRetry;

  NotificationError({required this.error, this.onRetry});
}