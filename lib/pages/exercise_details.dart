import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/db/moor_db.dart';
import 'package:workout_tracker/models/data_model.dart';
import 'package:workout_tracker/utils/colors.dart';
import 'package:workout_tracker/utils/textStyles.dart';

class ExerciseDetail extends StatefulWidget {
  ExerciseDetail({this.exercise, this.isEdit});
  final Exercise exercise;
  final bool isEdit;
  @override
  _ExerciseDetailState createState() => _ExerciseDetailState();
}

class _ExerciseDetailState extends State<ExerciseDetail> {
  //All the TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  //globalKey for froms
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();

  //Store the Data of the Sets
  List<Data> setsData = [];

  //Add Set Data to the SetsData list
  void addSet() {
    if (formKey1.currentState.validate()) {
      Data data = Data(
        reps: int.parse(repsController.text),
        weight: double.parse(weightController.text),
      );

      setState(() {
        setsData.add(data);
      });

      Navigator.pop(context);
    }
  }

  //This method sets all the field to their value when on editing screen
  // fields are empty when user crates new exercicse
  void setAllTheInputs() {
    nameController.text = widget.exercise.name;
    noteController.text = widget.exercise.note;

    List dataDecoded = json.decode(widget.exercise.data);

    for (var i = 0; i < dataDecoded.length; i++) {
      Data data = Data(
        reps: dataDecoded[i]['reps'],
        weight: dataDecoded[i]['weight'],
      );

      setsData.add(data);
    }
  }

  @override
  void initState() {
    if (widget.isEdit) {
      setAllTheInputs();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Exercise Name Text Field
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Exercise name",
                      hintText: "Exercise name",
                    ),
                    autofocus: widget.isEdit ? false : true,
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Please enter the exercise name';
                      else
                        return null;
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 0),
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

                  // note textfiled
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 0),
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
                ],
              ),
            ),
          ],
        ),
      ),

      // Floating action Button
      //chnage fab according to the screen user on, edit or create.
      floatingActionButton:
          widget.isEdit ? editExerciseButton() : createNewExerciseButton(),
    );
  }

//ConfirmDelete of exercise
  void confirmDelete() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            title: Text('Delete ${widget.exercise.name}?'),
            content: Text('Exercise will be deleted!'),
            actions: [
              FlatButton(
                child: Text(
                  'CANCEL',
                  style: DialogActionNegative.light,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text(
                  'DELETE',
                  style: DialogActionPositive.light,
                ),
                onPressed: () {
                  final database =
                      Provider.of<AppDatabase>(context, listen: false);
                  database.deleteExercise(widget.exercise);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

//SpeedDial Floating action button
  SpeedDial editExerciseButton() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      heroTag: 'fab',
      closeManually: false,
      backgroundColor: MyColors.accentColor,
      activeBackgroundColor: Colors.pink,
      children: [
        SpeedDialChild(
          child: Icon(Icons.save_rounded),
          backgroundColor: Colors.green,
          label: 'Save',
          onTap: () {
            String setsDataString = json.encode(setsData);
            final exercicse = widget.exercise.copyWith(
              name: nameController.text,
              sets: setsData.length,
              data: setsDataString,
              note: noteController.text,
            );

            final database = Provider.of<AppDatabase>(context, listen: false);
            database.updateExercise(exercicse);
            Navigator.pop(context);
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.delete_rounded),
          backgroundColor: Colors.redAccent,
          label: 'Delete',
          onTap: () {
            confirmDelete();
          },
        ),
      ],
    );
  }

//Normal Floating action button
  FloatingActionButton createNewExerciseButton() {
    return FloatingActionButton(
      heroTag: 'fab',
      backgroundColor: MyColors.primaryColor,
      child: Icon(
        Icons.done_rounded,
        color: MyColors.black,
      ),
      onPressed: () {
        //Validate the textfields
        if (formKey.currentState.validate()) {
          //check if atleast one set is present
          if (setsData.isNotEmpty) {
            final setsDataString = jsonEncode(setsData);

            final exercise = Exercise(
              id: null,
              name: nameController.text,
              sets: setsData.length,
              date: DateTime.now(),
              note: noteController.text,
              data: setsDataString,
            );

            //Create instance of database
            final database = Provider.of<AppDatabase>(context, listen: false);

            //Insert Exercise Data to Database
            database.insertExercise(exercise);
            Navigator.pop(context);
          } else {
            //show snackbar if set is empty
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter atleast one set!')));
          }
        }
      },
    );
  }

//Input Dialog to Accept Sets Detail
  void showInputDialog() {
    FocusNode weight = FocusNode();
    FocusNode reps = FocusNode();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          titlePadding: EdgeInsets.only(top: 16.0, left: 16.0),
          contentPadding:
              EdgeInsets.only(top: 16.0, right: 16.0, bottom: 0.0, left: 16.0),
          actionsPadding: EdgeInsets.only(top: 0),
          title: Text("Add Set", style: DialogTitleStyle.light),
          content: Form(
            key: formKey1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  focusNode: weight,
                  autofocus: true,
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(labelText: "Weight", suffix: Text("Kg")),
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Please enter the weight';
                    else
                      return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'),
                    )
                  ],
                  onFieldSubmitted: (value) {
                    weight.unfocus();
                    FocusScope.of(context).requestFocus(reps);
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  focusNode: reps,
                  keyboardType: TextInputType.number,
                  controller: repsController,
                  decoration: InputDecoration(
                    hintStyle: InputHitnStyle.light,
                    labelText: "Reps",
                  ),
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Please enter the reps';
                    else
                      return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "CANCEL",
                style: DialogActionNegative.light,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("ADD", style: DialogActionPositive.light),
              onPressed: addSet,
            )
          ],
        );
      },
    );
  }

//Build the List of sets
  Widget buildSetList(List<Data> setsData) {
    return Column(children: [
      for (var i = 0; i < setsData.length; i++)
        Container(
          child: Row(
            children: [
              Text("#${(i + 1).toString()}  ", style: SetListCount.light),
              Text("${setsData[i].weight} ", style: SetListValue.light),
              Text("Kg ", style: SetListText.light),
              Text("for ", style: SetListText.light),
              Text("${setsData[i].reps} ", style: SetListValue.light),
              Text("Reps", style: SetListText.light),
            ],
          ),
        ),
    ]);
  }
}
