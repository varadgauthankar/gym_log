import 'package:flutter/material.dart';
import 'package:workout_tracker/pages/analytics.dart';
import 'package:workout_tracker/pages/exercise_details.dart';
import 'package:workout_tracker/pages/exercise_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExerciseList(),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        elevation: 2.0,
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ExerciseDetail()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
