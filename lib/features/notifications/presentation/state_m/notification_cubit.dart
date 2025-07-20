// lib/features/notifications/presentation/state_m/notification_cubit.dart
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bid_Mart/core/entities/empty_entity.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/notifications/data/models/requests/request.dart';
import 'package:Bid_Mart/features/notifications/domain/notification_enitity.dart';
import 'package:Bid_Mart/features/notifications/domain/notification_repository.dart';
import 'package:Bid_Mart/features/notifications/presentation/state_m/notification_state.dart';

class NotificationCubit extends Cubit<NotificationsState> {
  NotificationCubit(this.notificationRepo) : super(NotificationsInitial());

  final NotificationRepo notificationRepo;

  Future<void> fetchNotifications() async {
    emit(NotificationsLoading());
    try {
      Result<AppErrors, NotificationsEntity> result =
          await notificationRepo.getNotifications();

      result.pick(
        onData: (data) {
          log("Notifications Data in Cubit: ${data.notifications}");
          emit(NotificationsLoaded(
            notifications: data.notifications,
            unseenCount: data.unseenCount,
          ));
        },
        onError: (error) {
          emit(NotificationsError(
            error: CustomError(message: error.toString()),
            onRetry: () => fetchNotifications(),
          ));
        },
      );
    } catch (e) {
      emit(NotificationsError(
        error: CustomError(message: e.toString()),
        onRetry: () => fetchNotifications(),
      ));
    }
  }

  Future<void> markAsRead(int notificationId) async {
    emit(NotificationsLoading());
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
                  seen: "1",
                  url: notification.url,
                  createdAt: notification.createdAt,
                  arg:  notification.arg,
                  routeName: notification.routeName,
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
            emit(NotificationsActionSuccess(message: data.message));
          } else {
            fetchNotifications();
          }
        },
        onError: (error) {
          emit(NotificationsError(
            error: CustomError(message: error.toString()),
            onRetry: () => markAsRead(notificationId),
          ));
        },
      );
    } catch (e) {
      emit(NotificationsError(
        error: CustomError(message: e.toString()),
        onRetry: () => markAsRead(notificationId),
      ));
    }
  }

  Future<void> deleteNotification(int notificationId) async {
    emit(NotificationsLoading());
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
            emit(NotificationsActionSuccess(message: data.message));
          } else {
            fetchNotifications();
          }
        },
        onError: (error) {
          emit(NotificationsError(
            error: CustomError(message: error.toString()),
            onRetry: () => deleteNotification(notificationId),
          ));
        },
      );
    } catch (e) {
      emit(NotificationsError(
        error: CustomError(message: e.toString()),
        onRetry: () => deleteNotification(notificationId),
      ));
    }
  }
}
