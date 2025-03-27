import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyLang = "PrefsKeyLang";
const String pressKeyOnBoardingScreen = 'PressKeyOnBoardingScreen';
const String cookiesKey = 'cookiesKey';
const String pressKeyLoginScreen = 'PressKeyLoginScreen';
const String locationKey = 'locationKey';
const String userIdKey = 'userIdKey';
const String pushNotificationKey = 'pushNotificationKey';
const arabicLocale = Locale('ar', 'SA');
const englishLocale = Locale('en', 'US');

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLang);
    // ignore: unnecessary_null_comparison
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }

  Future<void> changeAppLanguage() async {
    String currentLang = await getAppLanguage();
    if (currentLang == LanguageType.english.getValue()) {
      _sharedPreferences.setString(
          prefsKeyLang, LanguageType.arabic.getValue());
    } else {
      _sharedPreferences.setString(
          prefsKeyLang, LanguageType.english.getValue());
    }
  }

  Future<Locale> getLocale() async {
    String currentLang = await getAppLanguage();
    if (currentLang == LanguageType.arabic.getValue()) {
      return arabicLocale;
    } else {
      return englishLocale;
    }
  }

  // onBoarding
  Future<void> setPressKeyOnBoardingScreen() async {
    _sharedPreferences.setBool(pressKeyOnBoardingScreen, true);
  }

  bool isPressKeyOnBoardingScreen() {
    return _sharedPreferences.getBool(pressKeyOnBoardingScreen) ?? false;
  }

  //login
  Future<void> setPressKeyLoginScreen() async {
    _sharedPreferences.setBool(pressKeyLoginScreen, true);
  }

  Future<void> setLocationEnabled(bool value) async {
    _sharedPreferences.setBool(locationKey, value);
  }

  bool getLocationEnabled() {
    return _sharedPreferences.getBool(locationKey) ?? false;
  }

  Future<void> setFcmToken(String value) async {
    _sharedPreferences.setString(pushNotificationKey, value);
  }

  String getFcmToken() {
    return _sharedPreferences.getString(pushNotificationKey) ?? '';
  }

  Future<void> setUserId(String value) async {
    _sharedPreferences.setString(userIdKey, value);
  }

  String getUserId() {
    return _sharedPreferences.getString(userIdKey) ?? '';
  }

  Future<void> setNotificationEnabled(bool value) async {
    _sharedPreferences.setBool(pushNotificationKey, value);
  }

  bool getNotificationEnabled() {
    return _sharedPreferences.getBool(pushNotificationKey) ?? false;
  }

  bool isPressKeyLoginScreen() {
    return _sharedPreferences.getBool(pressKeyLoginScreen) ?? false;
  }

  // logout
  Future<void> logout() async {
    // await _sharedPreferences.remove(pressKeyOnBoardingScreen);
    removeAllCookies();
    await _sharedPreferences.remove(cookiesKey);
    await _sharedPreferences.remove(userIdKey);
    await _sharedPreferences.remove(pressKeyLoginScreen);
  }

  Future<void> remove(String key) async {
    _sharedPreferences.remove(key);
  }
  Future<void> removeAllCookies() async {
    List<String> keys = getCookiesKey();
    for (String key in keys) {
      await _sharedPreferences.remove(key);
    }
  }
  Future<void> setCookies(Map<String, String> value) async {
    await removeAllCookies();
    for (String key in value.keys) {
      await _sharedPreferences.setString(key, value[key] ?? '');
    }
    Set<String> keys = getCookiesKey().toSet();
    keys.addAll(value.keys);
    await _sharedPreferences.setStringList(cookiesKey, keys.toList());
    print('on set  cookies ${_sharedPreferences.getStringList(cookiesKey)}');
    print(getCookies());
  }

  List<String> getCookiesKey() {
    return _sharedPreferences.getStringList(cookiesKey) ?? [];
  }

  String getCookie(String key) {
    return _sharedPreferences.getString(key) ?? '';
  }

  List<String> getCookies() {
    List<String> cookies = [];
    for (String key in getCookiesKey()) {
      String cookie = "$key=${getCookie(key)}";
      cookies.add(cookie);
    }
    return  cookies;
  }
}
