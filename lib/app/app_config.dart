// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:Bid_Mart/core/app_options/app_options.dart';
// import 'package:Bid_Mart/app/app_prefs.dart';
// import 'package:Bid_Mart/core/constants/enums/app_theme_enum.dart';
// import 'package:Bid_Mart/core/constants/enums/system_type.dart';
// import 'package:Bid_Mart/app/di.dart';


// class AppConfig {
//   static final AppConfig _instance = AppConfig._internal();

//   factory AppConfig() {
//     return _instance;
//   }

//   AppConfig._internal();

//   String? _appLanguage;
//   final String apiKey = "";
//   SystemType? _os;
//   String? _currentVersion;
//   String? _buildNumber;
//   String? _appName;
//   String? _appVersion;
//   Map? _lastCard;
//   final AppThemes _appTheme = AppThemes.LIGHT;
//   final AppOptions _appOptions = AppOptions();
//   bool connectEnternet = true;

//   SystemType? get os => _os;
//   String bassel = "";

//   setBasselValue(String value) {
//     bassel = value;
//   }

//   String? get currentVersion => _currentVersion;

//   String? get buildNumber => _buildNumber;

//   String? get appVersion => _appVersion;

//   Map? get LastCard => _lastCard;

//   String? get appName => _appName;

//   AppOptions get appOptions => _appOptions;



//   ThemeMode get themeMode =>
//       _appTheme == AppThemes.LIGHT ? ThemeMode.light : ThemeMode.dark;

//   initApp() async {
//     /// get OS
//     if (Platform.isIOS) {
//       _os = SystemType.IOS;
//     }
//     if (Platform.isAndroid) {
//       _os = SystemType.Android;
//     }

//   }

//   /// read authToken
//   /// if returns null thats means there no SP instance
//   Future<String?> get authToken async {
//     final prefs = instance<AppPreferences>();
//     return prefs.getFcmToken();
//   }

//   /// read fcmToken
//   /// if returns null thats means there no SP instance

//   /// check if hasToken or not
//   Future<bool> get hasToken async {
//     final prefs = instance<AppPreferences>();
//     String token = prefs.getFcmToken();
//     return token.isNotEmpty;
//   }

//   /// check if hasFcmToken or not
//   Future<bool> get hasFcmToken async {
//     final prefs = instance<AppPreferences>();
//     String? token = prefs.getFcmToken();
//     if (token.isNotEmpty) return true;
//     return false;
//   }
//   String? get appLanguage => _appLanguage;
// }
