// lib/features/notifications/presentation/state_m/notification_cubit.dart
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/notifications/data/models/requests/request.dart';
import 'package:peakmart/features/notifications/domain/notification_enitity.dart';
import 'package:peakmart/features/notifications/domain/notification_repository.dart';
import 'package:peakmart/features/notifications/presentation/state_m/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.notificationRepo) : super(NotificationInitial());

  final NotificationRepo notificationRepo;

  Future<void> fetchNotifications() async {
    emit(NotificationLoading());
    try {
      Result<AppErrors, NotificationsEntity> result =
          await notificationRepo.getNotifications();

      result.pick(
        onData: (data) {
          emit(NotificationsLoaded(
            notifications: data.notifications,
            unseenCount: data.unseenCount,
          ));
        },
        onError: (error) {
          emit(NotificationError(
            error: CustomError(message: error.toString()),
            onRetry: () => fetchNotifications(),
          ));
        },
      );
    } catch (e) {
      emit(NotificationError(
        error: CustomError(message: e.toString()),
        onRetry: () => fetchNotifications(),
      ));
    }
  }

  Future<void> markAsRead(int notificationId) async {
    emit(NotificationLoading());
    try {
      Result<AppErrors, EmptyEntity> result =
          await notificationRepo.updateNotification(
              notificationRequest:
                  NotificationRequest(notificationId: notificationId));

      result.pick(
        onData: (data) {
          if (state is NotificationsLoaded) {
            final currentState = state as NotificationsLoaded;
            final updatedNotifications =
                currentState.notifications.map((notification) {
              if (notification.id == notificationId) {
                return NotificationEntity(
                  id: notification.id,
                  title: notification.title,
                  icon: notification.icon,
                  userId: notification.userId,
                  description: notification.description,
                  seen: true,
                  url: notification.url,
                  createdAt: notification.createdAt,
                );
              }
              return notification;
            }).toList();
            final newUnseenCount = currentState.unseenCount > 0
                ? currentState.unseenCount - 1
                : currentState.unseenCount;
            emit(NotificationsLoaded(
              notifications: updatedNotifications,
              unseenCount: newUnseenCount,
            ));
            emit(NotificationActionSuccess(message: data.message));
          } else {
            fetchNotifications();
          }
        },
        onError: (error) {
          emit(NotificationError(
            error: CustomError(message: error.toString()),
            onRetry: () => markAsRead(notificationId),
          ));
        },
      );
    } catch (e) {
      emit(NotificationError(
        error: CustomError(message: e.toString()),
        onRetry: () => markAsRead(notificationId),
      ));
    }
  }

  Future<void> deleteNotification(int notificationId) async {
    emit(NotificationLoading());
    try {
      Result<AppErrors, EmptyEntity> result =
          await notificationRepo.deleteNotification(
              notificationRequest:
                  NotificationRequest(notificationId: notificationId));

      result.pick(
        onData: (data) {
          if (state is NotificationsLoaded) {
            final currentState = state as NotificationsLoaded;
            final updatedNotifications = currentState.notifications
                .where((notification) => notification.id != notificationId)
                .toList();
            final newUnseenCount = currentState.unseenCount > 0 &&
                    currentState.notifications
                            .firstWhere((n) => n.id == notificationId)
                            .seen ==
                        false
                ? currentState.unseenCount - 1
                : currentState.unseenCount;
            emit(NotificationsLoaded(
              notifications: updatedNotifications,
              unseenCount: newUnseenCount,
            ));
            emit(NotificationActionSuccess(message: data.message));
          } else {
            fetchNotifications();
          }
        },
        onError: (error) {
          emit(NotificationError(
            error: CustomError(message: error.toString()),
            onRetry: () => deleteNotification(notificationId),
          ));
        },
      );
    } catch (e) {
      emit(NotificationError(
        error: CustomError(message: e.toString()),
        onRetry: () => deleteNotification(notificationId),
      ));
    }
  }
}
