import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  bool isDark = false;

  // Theme change karne ka function
  Future<void> toggleTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    isDark = !isDark;

    await pref.setBool("theme", isDark);

    notifyListeners();
  }

  // Saved theme load karne ka function
  Future<void> getTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    isDark = pref.getBool("theme") ?? false;

    notifyListeners();
  }
}
