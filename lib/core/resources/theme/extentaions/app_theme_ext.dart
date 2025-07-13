import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/theme/app_theming_cubit/app_theme_cubit.dart';

extension AppThemeExt on BuildContext {
  bool get isDarkMode {
    final themeMode = watch<AppThemeCubit>().state;
    return themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            MediaQuery.of(this).platformBrightness == Brightness.dark);
  }

  ThemeData get theme => Theme.of(this);
  get primaryColor =>
      isDarkMode ? ColorManager.darkModePrimary : ColorManager.primary;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
