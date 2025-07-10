import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:peakmart/app/app.dart';
import 'package:peakmart/features/products/presentation/views/product_details/product_details_view.dart';

// c24qzZuFTje8AkLeAHGCwe:APA91bHkxSVwOiA9dqlWFZT5JtaqVT1Zodi2Ww6XzkHABbjthVqF_Kf8sNs5aqJs2S26gY4WCWAH_V92Mn8DwdE4YBKkQGRqFcPO3ksEywzzHsfSP8zGT-M
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Background message: ${message.notification?.title}');
  log('Body : ${message.notification?.body}');
  log('notifdction : ${message.toMap()}');
}

class FirebaseCloudMessagingService {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static StreamController streamController = StreamController();
  static String? token;
  static RemoteMessage? initialMessage;
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
      log('Foreground message: ${message.notification?.title}');
      log('foreground ${message.toMap()}');
      log("Notification: ${message.data}");
      streamController.add(message);
    //* increase the icon by 1
      // Add logic to show notification in UI
      // final notification = message.notification;

      // LocalNotificationService.showNotification(
      //   id: 00,
      //   title: notification!.title!,
      //   body: notification.body!,
      // );
    });

    // Handle notification clicks
    await setupInteractMessage();
  }

  // Handle notification clicks (background/terminated)
  static Future<void> setupInteractMessage() async {
    // 🟠 الرسالة لو التطبيق مقفول تمامًا
    initialMessage = await messaging.getInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationNavigation(message);
    });
  }

  static void _handleNotificationNavigation(RemoteMessage message) {
    final navigator = MyApp.navigatorKey.currentState;
    if (navigator == null) return;

    final productIdString = message.data['product_id'];
    final productId = int.tryParse(productIdString ?? '') ?? 0;

    navigator.pushNamed(
      ProductDetails.routeName,
      arguments: productId,
    );
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
