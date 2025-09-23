import 'package:flutter/material.dart';

class AppStateModel extends ChangeNotifier {
  AppStateModel({required this.appLocale, this.themeMode = ThemeMode.light});

  Locale appLocale;
  ThemeMode themeMode = ThemeMode.light;

  void setLanguageCode(String newLanguageCode) {
    if (appLocale.languageCode != newLanguageCode) {
      appLocale = Locale(newLanguageCode);
      notifyListeners();
    }
  }

  void toggleThemeMode() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
