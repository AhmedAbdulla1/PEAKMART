import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppThemeCubit extends HydratedCubit<ThemeMode> {
  AppThemeCubit() : super(ThemeMode.system);

  bool isDarkMode = false;

  void changeTheme(ThemeMode themeMode, {required bool isDarkMode}) {
    log('Theme changed to: $themeMode');
    this.isDarkMode = isDarkMode;
    emit(themeMode);
  }

  final String themeModeKey = 'themeMode';

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    final theme = json[themeModeKey];
    isDarkMode = theme == 'dark';
    return theme == 'dark'
        ? ThemeMode.dark
        : theme == 'light'
            ? ThemeMode.light
            : ThemeMode.system;
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {themeModeKey: state == ThemeMode.dark ? 'dark' : 'light'};
  }
}
