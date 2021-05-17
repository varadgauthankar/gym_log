import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:workout_tracker/db/moor_db.dart';
import 'package:workout_tracker/models/data_model.dart';
import 'package:workout_tracker/pages/exercise_details.dart';
import 'package:workout_tracker/utils/colors.dart';
import 'package:workout_tracker/utils/textStyles.dart';

class ExerciseCard extends StatelessWidget {
  Exercise exercise;
  int index;

  ExerciseCard({this.exercise, this.index});

  @override
  Widget build(BuildContext context) {
    // print(ex);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseDetail(
              exercise: exercise,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: MyColors.primaryColor.withOpacity(.3),
              blurRadius: 6.0,
              offset: Offset(2.0, 2.0),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  exercise.name,
                  style: CardTitleStyle.darkLight,
                ),
                Text(
                  index.toString(),
                  style: CardExNumberStyle.light,
                ),
              ],
            ),
            Text(
              "${exercise.data.length.toString()} sets",
              style: CardSubTitleStyle.light,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
              height: 3.0,
              decoration: BoxDecoration(
                  color: MyColors.lightGrey,
                  borderRadius: BorderRadius.circular(12.0)),
            ),
            // buildDataList(exercise),
          ],
        ),
      ),
    );
  }

  String fun() {
    String d = json.decode(exercise.data);
  }

  Widget buildDataList(Exercise data) {
    // AppDatabase appDatabase = AppDatabase();
    // appDatabase.deleteExercise(data);
    var dataDecoded = json.decode(data.data);
    print("data ${data.data}");
    return Column(
        children: dataDecoded.map<Widget>((item) {
      return Row(
        children: [
          Text("#$index ", style: CardPreNumStyle.darkLight),
          Text("f", style: CardValueStyle.light),
          Text(" Kg for ", style: CardMainStyle.light),
          Text(item.toString(), style: CardValueStyle.light),
          Text(" Reps", style: CardMainStyle.light),
        ],
      );
    }).toList());
  }
}
