import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:peakmart/features/notifications/domain/notification_enitity.dart';

// c24qzZuFTje8AkLeAHGCwe:APA91bHkxSVwOiA9dqlWFZT5JtaqVT1Zodi2Ww6XzkHABbjthVqF_Kf8sNs5aqJs2S26gY4WCWAH_V92Mn8DwdE4YBKkQGRqFcPO3ksEywzzHsfSP8zGT-M
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Background message: ${message.notification?.title}');
  log('Body : ${message.notification?.body}');
  log('notifdction : ${message.toMap()}');
}

class FirebaseCloudMessagingService {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final StreamController<NotificationEntity> streamController =
      StreamController.broadcast();
  static String? token;

  // Initialize FCM
  static Future<void> initialize() async {
    // Request permissions
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else {
      log('User declined or has not accepted permission');
    }
    // Get and log FCM token
    token = await messaging.getToken();
    log('FCM Token: $token');

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        final NotificationEntity newNotification = NotificationEntity(
          id: DateTime.now().millisecondsSinceEpoch,
          title: notification.title ?? 'No Title',
          description: notification.body ?? '',
          seen: "0",
          createdAt: DateTime.now().toIso8601String(),
          icon: null,
          userId: 290,
        );
        log('Foreground message: ${message.notification?.title}');
        log('foreground ${message.toMap()}');
        log("Notification: ${message.data}");
        streamController.add(newNotification);
        log("✅ Notification added to stream: ${newNotification.title}");
      }
    });

    //* increase the icon by 1
    // Add logic to show notification in UI
    // final notification = message.notification;

    // LocalNotificationService.showNotification(
    //   id: 00,
    //   title: notification!.title!,
    //   body: notification.body!,
    // );

    // Handle notification clicks
    await setupInteractMessage();
  }

  // Handle notification clicks (background/terminated)
  static Future<void> setupInteractMessage() async {
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      log('App opened from terminated state: ${initialMessage.notification?.title}',
          name: 'from terminated');
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('App opened from background: ${message.notification?.title}',
          name: '');
    });
  }

  // Subscribe to a topic
  static Future<void> subscribeToTopic(String topic) async {
    await messaging.subscribeToTopic(topic);
    log('Subscribed to topic: $topic');
  }

  // Unsubscribe from a topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    await messaging.unsubscribeFromTopic(topic);
    log('Unsubscribed from topic: $topic');
  }
}
