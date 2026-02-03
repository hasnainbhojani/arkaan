import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'models/notification_model.dart';
import 'pages/splash.dart';
import 'pages/notifications.dart';
import 'services/language_service.dart';
import 'api/local_notifications.dart';
import 'models/notification_background_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🔔 Local notifications init
  await LocalNotificationService.init();

  // 🔴 Background handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // 🗄 Hive init
  await Hive.initFlutter();
  Hive.registerAdapter(NotificationModelAdapter());
  await Hive.openBox<NotificationModel>('notifications');

  final prefs = await SharedPreferences.getInstance();
  final initialLang = prefs.getString('selected_language') ?? '';

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LanguageService.a(initialLang),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // 🔹 Foreground messages
    FirebaseMessaging.onMessage.listen((msg) {
      _saveNotification(msg);
      LocalNotificationService.showNotification(msg);
    });

    // 🔹 App opened from background by tap
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      _saveNotification(msg);
      _openNotificationsPage();
    });

    // 🔹 App opened from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((msg) {
      if (msg != null) {
        _saveNotification(msg);
        _openNotificationsPage();
      }
    });
  }

  void _saveNotification(RemoteMessage msg) {
    final box = Hive.box<NotificationModel>('notifications');

    box.add(
      NotificationModel(
        title: msg.notification?.title,
        body: msg.notification?.body,
        timestamp: DateTime.now(),
      ),
    );
  }

  void _openNotificationsPage() {
    Get.to(() => const NotificationsPage());
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rehnuma-E-Hajj Ziyarat',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: const ColorScheme.dark(),
      ),
      home: const SplashScreen(),
    );
  }
}
