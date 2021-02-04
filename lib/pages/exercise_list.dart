import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/db/moor_db.dart';
import 'package:workout_tracker/utils/colors.dart';
import 'package:workout_tracker/utils/textStyles.dart';
import 'package:workout_tracker/widgets/card.dart';
import 'package:intl/intl.dart';

class ExerciseList extends StatelessWidget {
  String dateToday = DateFormat("EEEE, d").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: MyColors.white,
          elevation: 3,
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

  StreamBuilder<List<Exercise>> buildExerciseList(BuildContext context) {
    final databse = Provider.of<AppDatabase>(context);

    return StreamBuilder(
      stream: databse.wathcAllExercises(),
      builder: (context, AsyncSnapshot<List<Exercise>> snapshot) {
        final exercises = snapshot.data;

        return ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (_, index) {
            final exercise = exercises[index];
            return ExerciseCard(
              exercise: exercise,
              index: index,
            );
          },
        );
      },
    );
  }
}
