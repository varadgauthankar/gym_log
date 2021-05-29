import 'dart:math';

import 'package:flutter/material.dart';

bool isThemeDark(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

double roundDouble(double val, int places) {
  double mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}
