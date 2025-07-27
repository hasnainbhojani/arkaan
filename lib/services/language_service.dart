import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService extends ChangeNotifier {
  static const String _prefsKey = 'selected_language';
  String _currentLanguage = '';
  bool _isFirstTime = true;

  LanguageService() {
    _loadLanguage();
  }

  LanguageService.a(String initialLanguage)
      : _currentLanguage = initialLanguage,
        _isFirstTime = initialLanguage.isEmpty;

  String get currentLanguage => _currentLanguage;
  bool get isFirstTime => _isFirstTime;

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString(_prefsKey) ?? '';
    _isFirstTime = _currentLanguage.isEmpty;
    notifyListeners();
  }

  Future<void> setLanguage(String language) async {
    _currentLanguage = language;
    _isFirstTime = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, language);
    notifyListeners();
  }

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString(_prefsKey) ?? '';
    notifyListeners();
  }
}
