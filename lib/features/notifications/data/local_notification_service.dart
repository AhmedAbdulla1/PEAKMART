import 'dart:async';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  //* create an instance
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();
  static onTap(NotificationResponse notificationResponse) {
    //* handle notification tap event
    streamController.add(notificationResponse);
  }

  //* initialize
  static Future initLocalNotifications() async {
    await askPermission();
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  static Future<void> askPermission() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
        
  }

  static Future<void> setupLocation() async {
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }

  //* basic Notification
  static void showBasicNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await askPermission();
    AndroidNotificationDetails android = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    log("showBasicNotification");
    NotificationDetails details = NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      details,
      payload: "Payload Data",
    );
  }

  //* Show Repeated Notification
  static void showRepeatedNotification() async {
    await askPermission();
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'id 2',
      'repeated notification',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = const NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      'Reapated Notification',
      'body',
      androidScheduleMode: AndroidScheduleMode.exact,
      RepeatInterval.everyMinute, //! repeat every minute
      details,
      payload: "Payload Data",
    );
  }

  //* Show Schduled Notification
  static void showSchduledNotification() async {
    await askPermission();
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'schduled notification',
      'id 3',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = const NotificationDetails(android: android);
    await setupLocation();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      'Schduled Notification',
      'body',
      tz.TZDateTime.now(
        tz.local,
      ).add(const Duration(seconds: 10)), //! 10 seconds later

      androidScheduleMode: AndroidScheduleMode.exact,
      details,
      payload: 'zonedSchedule',
    );
  }

  //* cancel Notification By Id
  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  //* cancel All Notification
  static void cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}


/* 
! to add custom notification sound
   - add sound file in android/app/src/main/res/raw
   - add sound to assets, then add to pubspec.yaml 

*/