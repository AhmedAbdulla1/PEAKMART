import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:peakmart/core/app_options/app_options.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/core/constants/app/app_constants.dart';
import 'package:peakmart/core/constants/enums/app_theme_enum.dart';
import 'package:peakmart/core/constants/enums/system_type.dart';
import 'package:peakmart/app/di.dart';

import '../../main.dart';

/// This class it contain multiple core functions
/// for get device info
/// for get and set language
/// for current app theme
/// for options in application
class AppConfig {
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();

  String? _appLanguage;
  final String apiKey = "";
  SystemType? _os;
  String? _currentVersion;
  String? _buildNumber;
  String? _appName;
  String? _appVersion;
  Map? _LastCard;
  AppThemes _appTheme = AppThemes.LIGHT;
  AppOptions _appOptions = AppOptions();
  bool connectEnternet = true;

  SystemType? get os => _os;
  String bassel = "";

  setBasselValue(String value) {
    bassel = value;
  }

  String? get currentVersion => _currentVersion;

  String? get buildNumber => _buildNumber;

  String? get appVersion => _appVersion;

  Map? get LastCard => _LastCard;

  String? get appName => _appName;

  AppOptions get appOptions => _appOptions;

  bool get isLTR =>
      (appLanguage?.startsWith(AppConstants.LANG_EN) ?? false) ? true : false;


  ThemeMode get themeMode =>
      _appTheme == AppThemes.LIGHT ? ThemeMode.light : ThemeMode.dark;

  initApp() async {
    /// get OS
    if (Platform.isIOS) {
      _os = SystemType.IOS;
    }
    if (Platform.isAndroid) {
      _os = SystemType.Android;
    }

    /// get version
    // final packageInfo = await PackageInfo.fromPlatform();
    // _currentVersion = packageInfo.version;
    // _buildNumber = packageInfo.buildNumber;
    // _appName = packageInfo.appName;

    /// Get Initital App Theme

  }

  /// read authToken
  /// if returns null thats means there no SP instance
  Future<String?> get authToken async {
    final prefs = await instance<AppPreferences>();
    return prefs.getFcmToken();
  }

  /// read fcmToken
  /// if returns null thats means there no SP instance


  /// check if hasToken or not
  Future<bool> get hasToken async {
    final prefs = await instance<AppPreferences>();
    String? token = prefs.getFcmToken();
    if (token != null) return true;
    return false;
  }

  /// check if hasFcmToken or not
  Future<bool> get hasFcmToken async {
    final prefs = await instance<AppPreferences>();
    String? token = prefs.getFcmToken();
    if (token != null && token.isNotEmpty) return true;
    return false;
  }

  /// Persist App Theme


  /// Get APP Theme


  String? get appLanguage => _appLanguage;



}
