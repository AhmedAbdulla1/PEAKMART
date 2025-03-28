import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/theme/app_theming_cubit/app_theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
extension AppThemeExt on BuildContext {
  bool get isDarkMode {
    final themeMode = read<AppThemeCubit>().state;
    print('themeMode in isDarkMode: $themeMode');
    return themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            MediaQuery.of(this).platformBrightness == Brightness.dark);
  }

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
