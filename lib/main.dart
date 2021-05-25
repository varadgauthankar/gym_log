import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/db/moor_db.dart';
import 'package:workout_tracker/pages/exercise_list.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:workout_tracker/utils/colors.dart';
import 'package:workout_tracker/utils/theme_stuff.dart';

void main() async {
  runApp(
      EasyDynamicThemeWidget(initialThemeMode: ThemeMode.dark, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AppDatabase(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: MyColors.primaryColor,
          accentColor: MyColors.accentColor,
          primarySwatch: Colors.deepPurple,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: MyColors.primaryColor,
          accentColor: MyColors.accentColor,
          primarySwatch: Colors.deepPurple,
        ),
        themeMode: EasyDynamicTheme.of(context).themeMode,
        home: ExerciseList(),
      ),
    );
  }
}
