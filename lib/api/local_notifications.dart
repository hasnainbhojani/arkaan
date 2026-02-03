import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hajj/models/notification_model.dart';
import 'package:hive/hive.dart';

class LocalNotificationService {
  static final _fln = FlutterLocalNotificationsPlugin();

  /// 🔴 HIGH IMPORTANCE CHANNEL WITH SOUND
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel', // 🔴 MUST MATCH MANIFEST
    'High Importance Notifications',
    description: 'Notifications with sound',
    importance: Importance.max, // 🔴 REQUIRED
    sound: RawResourceAndroidNotificationSound('bell'),
    playSound: true, // 🔴 REQUIRED
  );

  static Future<void> init() async {
    // 🔹 Android init
    const androidSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const settings = InitializationSettings(android: androidSettings);

    await _fln.initialize(settings);

    // 🔴 CREATE CHANNEL BEFORE ANY NOTIFICATION ARRIVES
    await _fln
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // 🔹 Request permission (Android 13+ & iOS)
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> showNotification(RemoteMessage message) async {
    final box = Hive.box<NotificationModel>('notifications');

    // Save notification
    await box.add(
      NotificationModel(
        title: message.notification?.title,
        body: message.notification?.body,
        timestamp: DateTime.now(),
      ),
    );

    // Trim old notifications
    if (box.length > 10) {
      await box.deleteAt(0);
    }

    final notification = message.notification;
    if (notification == null) return;

    await _fln.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel', // 🔴 SAME CHANNEL
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('bell'),
          playSound: true, // 🔴 FORCE SOUND
        ),
      ),
    );
  }
}
