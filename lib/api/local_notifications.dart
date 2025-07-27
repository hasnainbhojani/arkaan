import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hajj/models/notification_model.dart';
import 'package:hive/hive.dart';

class LocalNotificationService {
  /// Plugin instance
  static final _fln = FlutterLocalNotificationsPlugin();

  /// The Android channel used for all notifications
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'default_channel', // id
    'Default Notifications', // name
    description: 'General alerts', // description (Android 8.0+)
    importance: Importance.max,
  );

  /// Call this once from main() before runApp()
  static Future<void> init() async {
    // 1. Create the channel on Android
    await _fln
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // 2. Initialize the plugin
    const androidSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final settings = InitializationSettings(android: androidSettings);
    await _fln.initialize(settings);

    // 3. (iOS) Request permissions
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// Call this from your onMessage listener
  static Future<void> showNotification(RemoteMessage message) async {
    final box = Hive.box<NotificationModel>('notifications');

// 1. create the model
    final model = NotificationModel(
      title: message.notification?.title,
      body: message.notification?.body,
      timestamp: DateTime.now(),
    );

// 2. add to box
    await box.add(model);

// 3. trim the box if >10
    if (box.length > 10) {
      await box.deleteAt(0); // remove oldest
    }

    final notification = message.notification;
    final android = message.notification?.android;
    if (notification == null || android == null) return;

    await _fln.show(
      notification.hashCode, // id
      notification.title, // title
      notification.body, // body
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id, // must match channel id
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}
