import 'package:flutter/material.dart';

Future<DateTime> selectDate(BuildContext context) async {
  var today = DateTime.now();

  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: today,
    firstDate: DateTime(2001),
    lastDate: today.add(Duration(days: 365)),
  );
  return picked;
}
