import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/api/firebase_api.dart';
import 'package:hajj/api/local_notifications.dart';
import 'package:hajj/firebase_options.dart';
import 'package:hajj/models/notification_model.dart';
import 'package:hajj/pages/language.dart';
import 'package:hajj/pages/splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hajj/services/language_service.dart';
import 'package:hajj/widgets/bottomNavbar.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage msg) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // handle background message if needed…
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 1. Initialize the NotificationService
  await LocalNotificationService.init();

  // 2. Set up background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Hive.initFlutter();
  final prefs = await SharedPreferences.getInstance();
  final initialLang = prefs.getString('selected_language') ?? '';

  await Hive.initFlutter();
  // register the adapter
  Hive.registerAdapter(NotificationModelAdapter());
  // open a box to store notifications
  await Hive.openBox<NotificationModel>('notifications');

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
  // runApp(
  //   MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(create: (context) => LanguageService()),
  //     ],
  //     child: const MyApp(),
  //   ),
  // );
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

    // 3. Listen for foreground messages
    FirebaseMessaging.onMessage.listen((msg) {
      LocalNotificationService.showNotification(msg);
    });

    // (Optional) handle taps when app is opened via notification
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      print(msg);
    });
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
          colorScheme: ColorScheme.dark(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent),
      home: const SplashScreen(),
    );
  }
}
