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
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        body: SizedBox.expand(
          child: Image.asset(
            "assets/image/start.jpg",
            fit: BoxFit.cover, // 🔥 fills entire screen
          ),
        ),
      ),
    );
  }
}
