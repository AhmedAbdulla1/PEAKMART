import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/theme/app_theming_cubit/app_theme_cubit.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/profile/presentation/views/settings/custom_switch_list_tile.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});
  static const routeName = 'settings_view';

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isNotificationsActive = false;
  bool isDarkThemeActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.settings),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          children: [
            CustomSwitchListTile(
              title: AppStrings.notification,
              leadingIcon: isNotificationsActive
                  ? Icons.notifications_on_outlined
                  : Icons.notifications_off_outlined,
              isActive: isNotificationsActive,
              onNotificationsChanged: (value) {
                setState(() {
                  isNotificationsActive = value;
                });
              },
            ),
            16.vGap,
            CustomSwitchListTile(
              title: AppStrings.darkTheme,
              leadingIcon: Icons.dark_mode_outlined,
              isActive: context.read<AppThemeCubit>().isDarkMode,
              onNotificationsChanged: (value) {
                setState(() {
                  isDarkThemeActive = value;
                  if (isDarkThemeActive) {
                    context
                        .read<AppThemeCubit>()
                        .changeTheme(ThemeMode.dark, isDarkMode: true);
                  } else {
                    context
                        .read<AppThemeCubit>()
                        .changeTheme(ThemeMode.light, isDarkMode: false);
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
