import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';

ThemeMode themeMode(BuildContext context) {
  return EasyDynamicTheme.of(context).themeMode;
}

bool isThemeDark(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}
