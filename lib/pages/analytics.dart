import 'package:flutter/material.dart';
import 'package:gym_log/utils/colors.dart';
import 'package:gym_log/utils/textStyles.dart';

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 3,
        title: Text(
          "Analytics",
          style: AppBarTitleStyle.dark,
        ),
      ),
      body: Text("helllllllllllllllllllllllllllllllllllo"),
    );
  }
}
