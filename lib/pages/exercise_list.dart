import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/db/moor_db.dart';
import 'package:workout_tracker/pages/exercise_details.dart';
import 'package:workout_tracker/utils/colors.dart';
import 'package:workout_tracker/utils/textStyles.dart';
import 'package:workout_tracker/widgets/card.dart';
import 'package:intl/intl.dart';

class ExerciseList extends StatelessWidget {
  final String dateToday = DateFormat("EEEE, d").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: MyColors.white,
          elevation: 2,
          title: Text(
            dateToday,
            style: AppBarTitleStyle.dark,
          )),
      body: Column(
        children: [
          Expanded(
            child: buildExerciseList(context),
          )
        ],
      ),
    );
  }

  //Build the list of exercises
  StreamBuilder<List<Exercise>> buildExerciseList(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return StreamBuilder(
      stream: database.watchAllExercises(),
      builder: (context, AsyncSnapshot<List<Exercise>> snapshot) {
        final exercises = snapshot.data;

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
      },
    );
  }
}
