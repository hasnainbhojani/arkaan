import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // 🔐 Request permissions on iOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('📲 Permission granted: ${settings.authorizationStatus}');

    // 📬 Get FCM token
    final fcmToken = await _firebaseMessaging.getToken();
    print('🔑 FCM Token: $fcmToken');

    // 🔴 Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📩 Foreground message received: ${message.notification?.title}');
    });

    // 🔵 App opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('🚪 App opened from message: ${message.data}');
    });
  }
}
