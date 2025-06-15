import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMHandler {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeFCM(BuildContext context) async {
    await Firebase.initializeApp();

    final messaging = FirebaseMessaging.instance;

    // Request permission
    await messaging.requestPermission();

    // Get device token (optional)
    final token = await messaging.getToken();
    print("FCM Token: $token");

    // Initialize local notifications
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _localNotifications.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });
  }

  static Future<void> _showNotification(RemoteMessage message) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails('channel_id', 'channel_name'),
      iOS: DarwinNotificationDetails(),
    );

    await _localNotifications.show(
      0,
      message.notification?.title ?? 'Notification',
      message.notification?.body ?? '',
      details,
    );
  }
}
