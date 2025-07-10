import 'dart:async';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:peakmart/app/app.dart';
import 'package:peakmart/features/products/presentation/views/product_details/product_details_view.dart';
import 'package:peakmart/features/notifications/data/local_notification_service.dart';
import 'package:peakmart/features/notifications/domain/notification_enitity.dart';

// Handle background messages
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('📥 [BG] Title: ${message.notification?.title}');
  log('📥 [BG] Body : ${message.notification?.body}');
  log('📥 [BG] Full message : ${message.toMap()}');
}

class FirebaseCloudMessagingService {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final StreamController<NotificationEntity> streamController =
      StreamController.broadcast();
  static String? token;
  static RemoteMessage? initialMessage;
  // Initialize FCM

  // Initialize Firebase Cloud Messaging
  static Future<void> initialize() async {
    await _requestPermission();
    await _logFcmToken();
    _handleForegroundMessages();
    await setupInteractMessage();
  }

  static Future<void> _requestPermission() async {
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    log('🔐 Notification permission status: ${settings.authorizationStatus}');
  }

  static Future<void> _logFcmToken() async {
    token = await messaging.getToken();
    log('📲 FCM Token: $token');
  }

  static void _handleForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('📲 [Foreground] Raw Message: ${message.toMap()}');

      // Prefer notification if exists, else fallback to data
      final title =
          message.notification?.title ?? message.data['title'] ?? 'No Title';
      final body =
          message.notification?.body ?? message.data['body'] ?? 'No Body';

      final newNotification = NotificationEntity(
        id: DateTime.now().millisecondsSinceEpoch,
        title: title,
        description: body,
        seen: "0",
        createdAt: DateTime.now().toIso8601String(),
        icon: null,
        userId: 290,
      );

      streamController.add(newNotification);
      log("✅ Notification added to stream: $title");

      LocalNotificationService.showBasicNotification(
        id: 0,
        title: title,
        body: body,
      );
    });
  }

  // Handle notification clicks (background/terminated)
  static Future<void> setupInteractMessage() async {
    // 🟠 الرسالة لو التطبيق مقفول تمامًا
    initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      log('🟢 App opened from terminated state with: ${initialMessage!.notification?.title}');
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationNavigation(message);
      log('🔁 App opened from background with: ${message.notification?.title}');
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


  static Future<void> subscribeToTopic(String topic) async {
    await messaging.subscribeToTopic(topic);
    log('📌 Subscribed to topic: $topic');
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await messaging.unsubscribeFromTopic(topic);
    log('📌 Unsubscribed from topic: $topic');
  }
}
