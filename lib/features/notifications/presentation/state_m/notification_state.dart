// lib/features/notifications/presentation/state_m/notification_state.dart
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/features/notifications/domain/notification_enitity.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationEntity> notifications;
  final int unseenCount;

  NotificationsLoaded({
    required this.notifications,
    required this.unseenCount,
  });
}

class NotificationsActionSuccess extends NotificationsState {
  final String message;

  NotificationsActionSuccess({required this.message});
}

class NotificationsError extends NotificationsState {
  final CustomError error;
  final Function()? onRetry;

  NotificationsError({required this.error, this.onRetry});
}