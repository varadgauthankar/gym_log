import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_tracker/utils/colors.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primaryColor: MyColors.primaryColor,
  accentColor: MyColors.accentColor,
  primarySwatch: Colors.deepPurple,
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: MyColors.primaryColor,
  accentColor: MyColors.accentColor,
  primarySwatch: Colors.deepPurple,
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences prefs;

  ThemeMode theme;

  ThemeNotifier() {
    theme = ThemeMode.system;
    getThemeFromPrefs();
  }

  toggleTheme(String theme) {
    this.theme = covertStringDataToThemeModeData(theme);
    saveThemeToPrefs();
    notifyListeners();
  }

  ThemeMode covertStringDataToThemeModeData(String theme) {
    if (theme == "On") {
      return ThemeMode.dark;
    } else if (theme == "Off") {
      return ThemeMode.light;
    } else if (theme == "Follow System") {
      return ThemeMode.system;
    } else
      return ThemeMode.system;
  }

  String convertThemeModeDataToString(ThemeMode theme) {
    if (theme == ThemeMode.dark) {
      return "On";
    } else if (theme == ThemeMode.light) {
      return "Off";
    } else if (theme == ThemeMode.system) {
      return "Follow System";
    } else
      return "Follow System";
  }

  getThemeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String theme = prefs.getString(key);
    this.theme = covertStringDataToThemeModeData(theme);
    notifyListeners();
  }

  saveThemeToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, convertThemeModeDataToString(this.theme));
  }
}
