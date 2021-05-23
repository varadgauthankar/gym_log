import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:workout_tracker/db/moor_db.dart';
import 'package:workout_tracker/utils/colors.dart';
import 'package:workout_tracker/utils/textStyles.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final int index;

  ExerciseCard({this.exercise, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: MyColors.black.withOpacity(.3),
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
                '#${index + 1}',
                style: CardExNumberStyle.light,
              ),
            ],
          ),
          Text(
            getSetsNumber(),
            style: CardSubTitleStyle.light,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
            height: 3.0,
            decoration: BoxDecoration(
                color: MyColors.lightGrey,
                borderRadius: BorderRadius.circular(12.0)),
          ),
          buildDataList(exercise),
        ],
      ),
    );
  }

  String getSetsNumber() {
    int length = json.decode(exercise.data).length;
    return length < 2
        ? (length.toString() + " Set")
        : (length.toString() + " Sets");
  }

  Widget buildDataList(Exercise exercise) {
    List dataDecoded = json.decode(exercise.data);
    return Column(
      children: [
        for (var i = 0; i < dataDecoded.length; i++)
          Row(
            children: [
              Text("#${i + 1} ", style: CardPreNumStyle.darkLight),
              Text("${dataDecoded[i]['weight']}", style: CardValueStyle.light),
              Text(" Kg for ", style: CardMainStyle.light),
              Text('${dataDecoded[i]['reps']}', style: CardValueStyle.light),
              Text(" Reps", style: CardMainStyle.light),
            ],
          ),
      ],
    );
  }
}
