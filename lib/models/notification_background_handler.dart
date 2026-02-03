import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/notification_model.dart';
import '../firebase_options.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage msg) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(NotificationModelAdapter());
  }

  final box = await Hive.openBox<NotificationModel>('notifications');

  box.add(
    NotificationModel(
      title: msg.notification?.title,
      body: msg.notification?.body,
      timestamp: DateTime.now(),
    ),
  );
}
