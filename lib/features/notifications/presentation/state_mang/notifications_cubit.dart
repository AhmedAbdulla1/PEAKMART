// features/notifications/presentation/state_mang/notifications_cubit.dart
import 'dart:developer';

import 'package:hydrated_bloc/hydrated_bloc.dart';

class NotificationsCubit extends HydratedCubit<bool> {
  NotificationsCubit() : super(false);

  void activeNotifications(bool isActive) {
    log('Notifications active state changed to: $isActive');
    emit(isActive);
  }

  final String notificationsActiveKey = 'notificationsActive';

  @override
  bool? fromJson(Map<String, dynamic> json) {
    return json[notificationsActiveKey] as bool?;
  }

  @override
  Map<String, dynamic>? toJson(bool state) {
    return {notificationsActiveKey: state};
  }
}
