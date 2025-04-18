import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  late Box _settingsBox;

  ThemeNotifier() : super(ThemeMode.light) {
    _settingsBox = Hive.box('settings');
    final isDark = _settingsBox.get('isDarkMode', defaultValue: false);
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    final isDark = state == ThemeMode.dark;
    state = isDark ? ThemeMode.light : ThemeMode.dark;
    _settingsBox.put('isDarkMode', state == ThemeMode.dark);
  }
}

// Provider
final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
