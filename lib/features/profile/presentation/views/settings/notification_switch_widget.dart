import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/features/notifications/presentation/state_m/notifications_cubit.dart';
import 'package:peakmart/features/profile/presentation/views/settings/custom_switch_list_tile.dart';

// tile with icon and title
class NotificationSwitchTile extends StatelessWidget {
  const NotificationSwitchTile({super.key, this.onChanged});

  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, bool>(
      builder: (context, isActive) {
        return CustomSwitchListTile(
          title: 'Notifications',
          leadingIcon: isActive
              ? Icons.notifications_on_outlined
              : Icons.notifications_off_outlined,
          isActive: isActive,
          onNotificationsChanged: (value) {
            context.read<NotificationsCubit>().activeNotifications(value);
            onChanged?.call(value);
          },
        );
      },
    );
  }
}

// switch only
class NotificationSwitchIconOnly extends StatelessWidget {
  const NotificationSwitchIconOnly({super.key, this.onChanged});

  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, bool>(
      builder: (context, isActive) {
        return Switch(
          value: isActive,
          onChanged: (value) {
            context.read<NotificationsCubit>().activeNotifications(value);
            onChanged?.call(value);
          },
        );
      },
    );
  }
}
