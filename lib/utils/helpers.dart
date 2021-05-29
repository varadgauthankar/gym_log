import 'dart:math';

import 'package:flutter/material.dart';

bool isThemeDark(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

double roundDouble(double val, int places) {
  double mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}

// get the color of the overlay widget, just some material rules.
Color getOverLayColor(BuildContext context, Color color) {
  return Color.alphaBlend(ElevationOverlay.overlayColor(context, 1), color);
}

void snackBar(BuildContext context, {String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
