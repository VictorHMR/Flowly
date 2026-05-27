import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/config/theme/app_theme.dart';

class SettingsViewModel extends ChangeNotifier {
  FlexScheme currentScheme = FlexScheme.sakura;

  SettingsViewModel() {
    loadTheme();
  }

  Future<void> changeScheme(FlexScheme scheme) async {
    currentScheme = scheme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_scheme', scheme.name);
    notifyListeners();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedScheme = prefs.getString('theme_scheme');
    if (savedScheme != null) {
      currentScheme = FlexScheme.values.firstWhere(
        (e) => e.name == savedScheme,
        orElse: () => FlexScheme.sakura,
      );
      notifyListeners();
    }
  }

  ThemeData get lightTheme => AppTheme.light(currentScheme);
  ThemeData get darkTheme => AppTheme.dark(currentScheme);
}
