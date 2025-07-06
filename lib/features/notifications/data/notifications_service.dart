import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalService {
  static final OneSignalService _instance = OneSignalService._internal();

  factory OneSignalService() => _instance;

  OneSignalService._internal();

  static const String _oneSignalAppId = '312bcd73-c822-476f-ab9d-f7b43fdeb4b1';

  /// Initializes OneSignal with Firebase and sets up notification handlers
  Future<void> initialize() async {
    try {
      // Enable verbose logging for debugging (remove in production)
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
      OneSignal.initialize(_oneSignalAppId);
      // Use this method to prompt for push notifications.
      // We recommend removing this method after testing and instead use In-App Messages to prompt for notification permission.
      OneSignal.Notifications.requestPermission(true);

      // Handle foreground notifications
      OneSignal.Notifications.addForegroundWillDisplayListener((event) {
        final notification = event.notification;
        debugPrint(
          "Foreground notification: ${notification.title} - ${notification.body}",
        );
        // you can show a custom UI
      });

      // Handle notification opened
      OneSignal.Notifications.addClickListener((event) {
        final notification = event.notification;
        debugPrint(
          "Notification opened: ${notification.title} - ${notification.body}",
        );
        final data = notification.additionalData;
        if (data != null) {
          _handleNotificationData(data);
        }
      });

      // Handle in-app message clicks
      OneSignal.InAppMessages.addClickListener((event) {
        debugPrint("In-app message clicked: ${event.result.actionId}");
        _handleInAppMessageAction(event.result.actionId, event.result.url);
      });

      debugPrint("OneSignal initialized successfully");
    } catch (e) {
      debugPrint("Error initializing OneSignal: $e");
    }
  }

  /// Handles additional data in notifications
  void _handleNotificationData(Map<String, dynamic> data) {
    debugPrint("Notification data: $data");
    // if (data.containsKey('screen')) {
    //  Navigator.pushNamed(context, data['screen']);
    // }
  }

  /// Handles in-app message actions
  void _handleInAppMessageAction(String? actionId, String? url) {
    if (actionId != null) {
      debugPrint("In-app message action: $actionId");
      // Handle specific actions
      // Example:
      // if (actionId == "open_profile") {
      //   Navigator.pushNamed(context, '/profile');
      // }
    }
    if (url != null) {
      debugPrint("Opening URL: $url");
      // Handle Open URL
    }
  }

  /// Adds a user tag for segmentation
  Future<void> addTag(String key, String value) async {
    try {
      await OneSignal.User.addTagWithKey(key, value);
      debugPrint("Tag added: $key=$value");
    } catch (e) {
      debugPrint("Error adding tag: $e");
    }
  }

  /// Removes a user tag
  Future<void> removeTag(String key) async {
    try {
      await OneSignal.User.removeTag(key);
      debugPrint("Tag removed: $key");
    } catch (e) {
      debugPrint("Error removing tag: $e");
    }
  }

  /// Triggers an in-app message
  Future<void> triggerInAppMessage(
    String triggerKey,
    String triggerValue,
  ) async {
    try {
      OneSignal.InAppMessages.addTrigger(triggerKey, triggerValue);
      debugPrint("In-app message triggered: $triggerKey=$triggerValue");
    } catch (e) {
      debugPrint("Error triggering in-app message: $e");
    }
  }

  /// Pauses or resumes in-app messages
  Future<void> setInAppMessagesPaused(bool paused) async {
    try {
      OneSignal.InAppMessages.paused(paused);
      debugPrint("In-app messages ${paused ? 'paused' : 'resumed'}");
    } catch (e) {
      debugPrint("Error setting in-app messages pause state: $e");
    }
  }

  static void onNotificationClicked({required GlobalKey<NavigatorState> navigatorKey}) {
  String? screen;
  OneSignal.Notifications.addClickListener(
    (event) {
      log("Event: ${event.toString()}");
      final Map<String, dynamic>? data = event.notification.additionalData;
      screen = data?['screen'];
      if (screen != null) {
        navigatorKey.currentState?.pushNamed(screen!);
      }
    },
  );
}
}


