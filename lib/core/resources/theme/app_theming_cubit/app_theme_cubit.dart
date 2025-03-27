import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppThemeCubit extends HydratedCubit<ThemeMode> {
  AppThemeCubit() : super(ThemeMode.system);

  bool isDarkMode = false;
  void changeTheme(ThemeMode themeMode, {required bool isDarkMode}) {
    log(themeMode.toString());
    this.isDarkMode = isDarkMode;
    emit(themeMode);
  }

  final String themeModeKey = 'themeMode';
  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    if (json[themeModeKey] == 'dark') {
      isDarkMode = true;
      return ThemeMode.dark;
    } else if (json[themeModeKey] == 'light') {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    if (state == ThemeMode.dark) {
      isDarkMode = true;
      return {themeModeKey: 'dark'};
    } else if (state == ThemeMode.light) {
      return {themeModeKey: 'light'};
    } else {
      return {themeModeKey: 'system'};
    }
  }
}
