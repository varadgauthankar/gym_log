import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/db/moor_db.dart';
import 'package:workout_tracker/pages/exercise_list.dart';
import 'package:workout_tracker/utils/theme.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => AppDatabase(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
        )
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: light,
            darkTheme: dark,
            themeMode: notifier.theme,
            home: ExerciseList(),
          );
        },
      ),
    );
  }
}
