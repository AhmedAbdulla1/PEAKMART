// features/profile/presentation/views/settings/settings_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/string_manager.dart';
import 'package:Bid_Mart/core/resources/theme/app_theming_cubit/app_theme_cubit.dart';
import 'package:Bid_Mart/core/resources/values_manager.dart';
import 'package:Bid_Mart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:Bid_Mart/features/notifications/presentation/state_m/notifications_cubit.dart';
import 'package:Bid_Mart/features/profile/presentation/views/settings/custom_switch_list_tile.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});
  static const routeName = 'settings_view';

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    final notificationsCubit = context.read<NotificationsCubit>();
    final appThemeCubit = context.read<AppThemeCubit>();

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.settings),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          children: [
            BlocBuilder<NotificationsCubit, bool>(
              builder: (context, isNotificationsActive) {
                return CustomSwitchListTile(
                  title: AppStrings.notification,
                  leadingIcon: isNotificationsActive
                      ? Icons.notifications_on_outlined
                      : Icons.notifications_off_outlined,
                  isActive: isNotificationsActive,
                  onNotificationsChanged: (value) {
                    notificationsCubit.activeNotifications(value);
                  },
                );
              },
            ),
            16.vGap,
            BlocBuilder<AppThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                final bool isDarkThemeActive = themeMode == ThemeMode.dark ||
                    (themeMode == ThemeMode.system &&
                        MediaQuery.of(context).platformBrightness ==
                            Brightness.dark);

                return CustomSwitchListTile(
                  title: AppStrings.darkTheme,
                  leadingIcon: Icons.dark_mode_outlined,
                  isActive: isDarkThemeActive,
                  onNotificationsChanged: (value) {
                    appThemeCubit.changeTheme(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
