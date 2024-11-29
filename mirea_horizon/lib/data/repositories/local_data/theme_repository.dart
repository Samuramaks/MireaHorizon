import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:mirea_horizon/settings.dart';

class ThemeRepository {
  ThemeRepository({required this.preferences});

  final SharedPreferences preferences;
  static const String _themeKey = LocalKeys.themKey;

  Future<ThemeMode> getTheme() async {
    final themeString = preferences.getString(_themeKey) ?? 'system';
    return _getThemeModeFromString(themeString);
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    await preferences.setString(_themeKey, _getStringFromThemeMode(themeMode));
  }

  ThemeMode _getThemeModeFromString(String themeString) {
    switch (themeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  String _getStringFromThemeMode(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
      default:
        return 'system';
    }
  }
}
