import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/db/moor_db.dart';
import 'package:workout_tracker/pages/exercise_details.dart';
import 'package:workout_tracker/utils/colors.dart';
import 'package:workout_tracker/utils/date_picker.dart';
import 'package:workout_tracker/utils/textStyles.dart';
import 'package:workout_tracker/widgets/card.dart';
import 'package:intl/intl.dart';

class ExerciseList extends StatefulWidget {
  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  final String dateToday = DateFormat("EEEE, d").format(DateTime.now());

  DateTime date = DateTime.now();

  //get the date
  void getExerciseOnDate() async {
    DateTime newDate = await selectDate(context);
    setState(() {
      date = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: MyColors.white,
          elevation: 2,
          title: Text(
            DateFormat('EEE, d').format(date),
            style: AppBarTitleStyle.dark,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.calendar_today_rounded, color: Colors.black),
              tooltip: 'Select date',
              onPressed: () {
                getExerciseOnDate();
              },
            ),
          ]),
      body: Column(
        children: [
          Expanded(
            child: buildExerciseList(context),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        elevation: 2.0,
        child: Icon(Icons.add),
        foregroundColor: MyColors.black,
        backgroundColor: MyColors.accentColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExerciseDetail(
                isEdit: false,
                exercise: null,
              ),
            ),
          );
        },
      ),
    );
  }

//Build Exercise list
  StreamBuilder<List<Exercise>> buildExerciseList(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return StreamBuilder(
      stream: database.watchExerciseWithDate(date: date),
      builder: (context, AsyncSnapshot<List<Exercise>> snapshot) {
        final exercises = snapshot.data;
        if (snapshot.hasData) {
          if (snapshot.data.isNotEmpty) {
            return ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (_, index) {
                final exercise = exercises[index];
                return GestureDetector(
                  child: ExerciseCard(
                    exercise: exercise,
                    index: index,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExerciseDetail(
                          exercise: exercise,
                          isEdit: true,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else
            return Center(
                child:
                    Text("No Exercises yet")); //Add a beautiful graphics here
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
