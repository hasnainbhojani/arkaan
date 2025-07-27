import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hajj/pages/language.dart';
import 'package:hajj/widgets/bottomNavbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _delay = Duration(seconds: 4);
  Timer? _timer;
  bool _didNavigate = false;
  bool _initialChecksDone = false;

  var introText = '''ચાર મશહૂર મરજા ના ફતવા મુજબ આસાન તરીકા થી હજ ના મનાસિક''';

  @override
  void initState() {
    super.initState();
    // 1) start a timer
    _timer = Timer(_delay, _tryNavigate);
    // 2) run your initial checks in parallel
    _checkFirstLaunch().then((_) {
      _initialChecksDone = true;
      _tryNavigate();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _checkFirstLaunch() async {
    // any setup you need before navigation
    // e.g. await Hive.initFlutter();
    //      await setupLocator();
    await Future.delayed(const Duration(milliseconds: 0));
  }

  /// Attempt to move on — only does it once both the timer _and_ checks are done,
  /// unless we skip by tap (in which case we cancel the timer and mark both as done).
  Future<void> _tryNavigate() async {
    if (_didNavigate) return;

    // if either the timer hasn't fired yet, _delay, or the initial checks
    // haven't finished, bail out.
    if (!_initialChecksDone || (_timer?.isActive ?? false)) {
      return;
    }

    _didNavigate = true;
    final prefs = await SharedPreferences.getInstance();
    final hasSelectedLanguage = prefs.containsKey('selected_language');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => hasSelectedLanguage
            ? const navMenu()
            : const LanguageSelectorPage(),
      ),
    );
  }

  /// User tapped: cancel the timer, mark checks done, and try to navigate immediately.
  void _onTapSkip() {
    if (_didNavigate) return;
    _timer?.cancel();
    _initialChecksDone = true;
    _tryNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapSkip,
      behavior: HitTestBehavior.opaque, // so taps anywhere register
      child: Scaffold(
        body: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/image/logo.png",
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 25),
              Text(
                introText,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: 'MuktaVaani',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:hajj/pages/language.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:hajj/widgets/bottomNavbar.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   var introText = '''ચાર મશહૂર મરજા ના ફતવા મુજબ આસાન તરીકા થી હજ ના મનાસિક''';

//   @override
//   void initState() {
//     super.initState();
//     _initializeApp();
//   }

//   Future<void> _initializeApp() async {
//     // Wait for both splash duration and initial checks
//     await Future.wait([
//       Future.delayed(const Duration(seconds: 4)), // Minimum splash duration
//       _checkFirstLaunch(),
//     ]);

//     if (!mounted) return;

//     // Navigate to appropriate screen
//     final prefs = await SharedPreferences.getInstance();
//     final hasSelectedLanguage = prefs.containsKey('selected_language');

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => hasSelectedLanguage
//             ? const navMenu()
//             : const LanguageSelectorPage(),
//       ),
//     );
//   }

//   Future<void> _checkFirstLaunch() async {
//     // Add any additional initialization logic here
//     // Example: await Hive.initFlutter();
//     // Example: await setupLocator();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.black,
//         padding: EdgeInsets.all(15),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(
//               "assets/image/logo.png",
//               fit: BoxFit.cover,
//               height: 100,
//               width: 100,
//             ),
//             SizedBox(
//               height: 25,
//             ),
//             Text(
//               introText,
//               style: TextStyle(
//                   fontSize: 24, color: Colors.white, fontFamily: 'MuktaVaani'),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:hajj/pages/language.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:hajj/widgets/bottomNavbar.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _initializeApp();
//   }

//   Future<void> _initializeApp() async {
//     // Wait for both splash duration and initial checks
//     await Future.wait([
//       Future.delayed(const Duration(seconds: 4)), // Minimum splash duration
//       _checkFirstLaunch(),
//     ]);

//     if (!mounted) return;

//     // Navigate to appropriate screen
//     final prefs = await SharedPreferences.getInstance();
//     final hasSelectedLanguage = prefs.containsKey('selected_language');

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => hasSelectedLanguage
//             ? const navMenu()
//             : const LanguageSelectorPage(),
//       ),
//     );
//   }

//   Future<void> _checkFirstLaunch() async {
//     // Add any additional initialization logic here
//     // Example: await Hive.initFlutter();
//     // Example: await setupLocator();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.black, Color(0xFF1a1a1a)],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Your logo
//               Image.asset(
//                 "assets/image/logo.png",
//                 height: 150,
//                 width: 150,
//               ),
//               const SizedBox(height: 20),
//               // Loading indicator
//               const CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
//               ),
//               const SizedBox(height: 20),
//               // App name text
//               const Text(
//                 'Hajj Guide',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               // Optional subtitle
//               const Text(
//                 'Comprehensive Ritual Guide',
//                 style: TextStyle(
//                   color: Colors.white54,
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hajj/pages/language.dart';
// import 'package:hajj/widgets/bottomNavbar.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class splashScreen extends StatefulWidget {
//   const splashScreen({super.key});

//   @override
//   State<splashScreen> createState() => _splashScreenState();
// }

// class _splashScreenState extends State<splashScreen> {
//   var introText = '''ચાર મશહૂર મરજા ના ફતવા મુજબ આસાન તરીકા થી હજ ના મનાસિક''';

//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 4), () async {
//       final prefs = await SharedPreferences.getInstance();
//       if (!prefs.containsKey('selected_language')) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const LanguageSelectorPage()),
//         );
//       } else {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const navMenu()),
//         );
//       }
//     });
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: InkWell(
//         onTap: () {
//           Navigator.pushReplacement((this.context),
//               MaterialPageRoute(builder: ((context) => navMenu())));
//         },
//         child: Container(
//           color: Colors.black,
//           padding: EdgeInsets.all(15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 "assets/image/logo.png",
//                 fit: BoxFit.cover,
//                 height: 100,
//                 width: 100,
//               ),
//               SizedBox(
//                 height: 25,
//               ),
//               Text(
//                 introText,
//                 style: TextStyle(
//                     fontSize: 24,
//                     color: Colors.white,
//                     fontFamily: 'MuktaVaani'),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
