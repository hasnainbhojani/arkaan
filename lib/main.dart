// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hajj/pages/login.dart';
import 'package:hajj/pages/register.dart';
import 'package:hajj/pages/splash.dart';
import 'package:hajj/widgets/bottomNavbar.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rehnuma-E-Hajj Ziyarat',
      initialRoute: "/navMenu",
      routes: {
        '/navMenu': (context) => const navMenu(),
        '/splash': (context) => const splashScreen(),
      },
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.dark(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent),
      home: const navMenu(),
    );
  }
}
