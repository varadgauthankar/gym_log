import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_tracker/utils/enums.dart';

class UnitsNotifier extends ChangeNotifier {
  final String weightUnitKey = "weightUnit";

  // String weightUnit;
  WeightUnit weightUnit;

  UnitsNotifier() {
    weightUnit = WeightUnit.kg;
    getWeightUnitFromPrefs();
  }

  toggleWeightUnit(WeightUnit choice) {
    weightUnit = choice;
    saveWeightUnitToPrefs();
    notifyListeners();
  }

  getWeightUnitFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String prefsData = prefs.getString(weightUnitKey);
    weightUnit = weightEnumFromString(prefsData);
    notifyListeners();
  }

  saveWeightUnitToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(weightUnitKey, weightUnit.toString());
  }

  WeightUnit weightEnumFromString(String value) {
    return WeightUnit.values.firstWhere((e) => e.toString() == value);
  }
}
