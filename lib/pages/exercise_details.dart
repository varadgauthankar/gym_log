import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/db/moor_db.dart';
import 'package:workout_tracker/models/data_model.dart';
import 'package:workout_tracker/utils/colors.dart';
import 'package:workout_tracker/utils/textStyles.dart';
import "package:intl/intl.dart";

class ExerciseDetail extends StatefulWidget {
  ExerciseDetail({this.exercise});
  final Exercise exercise;
  @override
  _ExerciseDetailState createState() => _ExerciseDetailState();
}

class _ExerciseDetailState extends State<ExerciseDetail> {
  
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  List<Data> setsData = [];

  void addSet() {
    Data data = Data(
      reps: int.parse(repsController.text),
      weight: double.parse(weightController.text),
    );

    setState(() {
      setsData.add(data);
    });

    Navigator.pop(context);
  }

  


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 3,
        title: Text(
          "Edit Exercise",
          style: AppBarTitleStyle.dark,
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context)),
      ),

      // body
      body: Container(
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
            // Exercise Name Text Field
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Exercise name",
                hintText: "Exercise name",
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
              child: Text(
                "Sets",
                style: CardSubTitleStyle.light,
              ),
            ),

            // build Sets list with their data
            buildSetList(setsData),

            // Button to add set
            FlatButton(
              child: Text(
                "+ Add Set",
                style: AddSetButtonStyle.light,
              ),
              onPressed: showInputDialog,
            ),

            // note text
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: noteController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Note",
                      hintText: "Note",
                    ),
                  )
                ],
              ),
            ),

          //Tmporary Delete Button
            FlatButton(
              child: Text("Delete"),
              onPressed: () {
  final database = Provider.of<AppDatabase>(context, listen: false);

                database.deleteExercise(widget.exercise);
              },
            ),
          ],
        ),
      ),

      // Floating action Button
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        onPressed: () {
          // final setsDataString = jsonEncode(setsData);
          // print(setsDataString);
          final exercise = Exercise(
            name: nameController.text,
            sets: setsData.length,
            date: DateTime.now(),
            note: nameController.text,
            data: "setsDataString", //! fix thissssss
          );
  final database = Provider.of<AppDatabase>(context, listen: false);

          database.insertExercise(exercise);
          Navigator.pop(context);
        },
      ),
    );
  }

  void showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Set"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Weight",
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                keyboardType: TextInputType.number,
                controller: repsController,
                decoration: InputDecoration(
                  hintStyle: InputHitnStyle.light,
                  labelText: "Reps",
                ),
              ),
            ],
          ),
          actions: [
            FlatButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text("Add"),
              onPressed: addSet,
            )
          ],
        );
      },
    );
  }

  Widget buildSetList(List<Data> setsData) {
    return Column(children: [
      for (var i = 0; i < setsData.length; i++)
        Container(
          // color: Colors.red,
          padding: EdgeInsets.all(4.0),
          child: Row(
            children: [
              Text("#${(i + 1).toString()}  ", style: SetListCount.light),
              Text("${setsData[i].weight} ", style: SetListValue.light),
              Text("kg ", style: SetListText.light),
              Text("for ", style: SetListText.light),
              Text("${setsData[i].reps} ", style: SetListValue.light),
              Text("reps", style: SetListText.light),
            ],
          ),
        ),
    ]);
  }

  Widget setTextFieldContainer({Widget child}) {
    return Container(
      width: 50.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
      child: child,
    );
  }
}
