import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:gym_log/db/moor_db.dart';
import 'package:gym_log/models/data_model.dart';
import 'package:gym_log/utils/colors.dart';
import 'package:gym_log/utils/enums.dart';
import 'package:gym_log/utils/textStyles.dart';
import 'package:gym_log/utils/helpers.dart';
import 'package:gym_log/utils/units.dart';

class ExerciseDetail extends StatefulWidget {
  ExerciseDetail({this.exercise, this.isEdit, this.date});
  final Exercise exercise;
  final bool isEdit;
  final DateTime date;

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

  //temporarily Store the Data of the Sets
  List<Data> setsData = [];
  // Weight weight = Weight(kg: 0, lbs: 0)

  //Add Set Data to the SetsData list
  void addSet() {
    if (formKey1.currentState.validate()) {
      Data data = Data(
        reps: int.parse(repsController.text),
        weight: Weight(
          kg: Provider.of<UnitsNotifier>(context, listen: false).weightUnit ==
                  WeightUnit.kg
              ? roundDouble(double.parse(weightController.text), 1)
              : roundDouble(double.parse(weightController.text) / 2.2046, 0),
          lbs: Provider.of<UnitsNotifier>(context, listen: false).weightUnit ==
                  WeightUnit.kg
              ? roundDouble(double.parse(weightController.text) * 2.2046, 0)
              : roundDouble(double.parse(weightController.text), 1),
        ),
      );

      setState(() {
        setsData.add(data);
      });
      repsController.clear();
      weightController.clear();
      Navigator.pop(context);
    }
  }

  void updateSet(int index) {
    if (formKey1.currentState.validate()) {
      Data data = Data(
        reps: int.parse(repsController.text),
        weight: Weight(
          kg: Provider.of<UnitsNotifier>(context, listen: false).weightUnit ==
                  WeightUnit.kg
              ? roundDouble(double.parse(weightController.text), 1)
              : roundDouble(double.parse(weightController.text) / 2.2046, 0),
          lbs: Provider.of<UnitsNotifier>(context, listen: false).weightUnit ==
                  WeightUnit.kg
              ? roundDouble(double.parse(weightController.text) * 2.2046, 0)
              : roundDouble(double.parse(weightController.text), 1),
        ),
      );

      setState(() {
        setsData.removeAt(index);
        setsData.insert(index, data);
      });
      repsController.clear();
      weightController.clear();
      Navigator.pop(context);
    }
  }

  void deleteSet(int index) {
    setState(() {
      setsData.removeAt(index);
    });
  }

  //This method sets all the field to their value when on editing screen
  // fields are empty when user crates new exercicse
  void setAllTheInputs() {
    nameController.text = widget.exercise.name;
    noteController.text = widget.exercise.note;
    List dataDecoded = json.decode(widget.exercise.data);
    for (var i = 0; i < dataDecoded.length; i++) {
      var exData = dataDecoded[i];
      Data data = Data(
        reps: exData['reps'],
        weight: Weight(
          kg: exData['weight']['kg'],
          lbs: exData['weight']['lbs'],
        ),
      );
      setsData.add(data);
    }
  }

//save exercise
  void saveExercise(bool isEdit) {
    if (formKey.currentState.validate()) {
      //check if atleast one set is present
      if (setsData.isNotEmpty) {
        final setsDataString = jsonEncode(setsData);

        final exercise = isEdit
            ? widget.exercise.copyWith(
                name: nameController.text,
                sets: setsData.length,
                data: setsDataString,
                note: noteController.text,
              )
            : Exercise(
                id: null,
                name: nameController.text,
                sets: setsData.length,
                date: widget.date,
                note: noteController.text,
                data: setsDataString,
              );

        //Create instance of database
        final database = Provider.of<AppDatabase>(context, listen: false);

        //update Exercise Data to Database
        isEdit
            ? database.updateExercise(exercise)
            : database.insertExercise(exercise);
        Navigator.pop(context);
      } else {
        //show snackbar if set is empty
        snackBar(context, content: 'Please enter atleast one set!');
      }
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
    return WillPopScope(
      child: Scaffold(
        backgroundColor:
            isThemeDark(context) ? MyColors.darkGrey : MyColors.white,
        appBar: AppBar(
          elevation: 3,
          foregroundColor: MyColors.white,
          iconTheme: IconThemeData(color: MyColors.white),
          title: Hero(
            tag: 'appBarTitle',
            child: Material(
              color: Colors.transparent,
              child: Text(
                widget.isEdit ? "Edit Exercise" : "Create Exercise",
                style: AppBarTitleStyle.dark,
              ),
            ),
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
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Exercise name",
                        hintText: "Exercise name",
                      ),
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Please enter the exercise name';
                        else
                          return null;
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        "Sets",
                        style: isThemeDark(context)
                            ? CardSubTitleStyle.dark
                            : CardSubTitleStyle.light,
                      ),
                    ),

                    // build Sets list with their data
                    buildSetList(setsData),

                    // Button to add set
                    TextButton(
                      child: Text(
                        "+ Add Set",
                        style: isThemeDark(context)
                            ? AddSetButtonStyle.dark
                            : AddSetButtonStyle.light,
                      ),
                      onPressed: showSetsInputDialog,
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
      ),
      onWillPop: onWillPop,
    );
  }

  Future<bool> onWillPop() async {
    if (nameController.text.isNotEmpty || setsData.isNotEmpty) {
      print('in here hi');
      saveExercise(widget.isEdit);
    } else
      Navigator.pop(context);
    return null;
  }

//Confirm Delete of exercise
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
              TextButton(
                child: Text(
                  'CANCEL',
                  style: isThemeDark(context)
                      ? DialogActionNegative.dark
                      : DialogActionNegative.light,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text(
                  'DELETE',
                  style: isThemeDark(context)
                      ? DialogActionPositive.dark
                      : DialogActionPositive.light,
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
      overlayColor: isThemeDark(context) ? MyColors.black : MyColors.white,
      animatedIcon: AnimatedIcons.menu_close,
      heroTag: 'fab',
      elevation: 3.0,
      closeManually: false,
      backgroundColor: MyColors.accentColor,
      foregroundColor: MyColors.black,
      children: [
        SpeedDialChild(
          child: Icon(Icons.save_rounded),
          foregroundColor: MyColors.black,
          backgroundColor: Colors.green,
          label: 'Save',
          labelBackgroundColor:
              isThemeDark(context) ? MyColors.darkGrey : MyColors.white,
          onTap: () => saveExercise(widget.isEdit),
        ),
        SpeedDialChild(
          child: Icon(Icons.delete_rounded),
          foregroundColor: MyColors.black,
          backgroundColor: Colors.redAccent,
          label: 'Delete',
          labelBackgroundColor:
              isThemeDark(context) ? MyColors.darkGrey : MyColors.white,
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
      elevation: 3.0,
      // backgroundColor: MyColors.primaryColor,
      child: Icon(
        Icons.done_rounded,
        color: MyColors.black,
      ),
      onPressed: () => saveExercise(widget.isEdit),
    );
  }

//Input Dialog to Accept Sets Detail
  void showSetsInputDialog(
      {List<Data> setData, int index, bool isEdit = false}) {
    FocusNode weight = FocusNode();
    FocusNode reps = FocusNode();
    if (isEdit) {
      weightController.text =
          Provider.of<UnitsNotifier>(context, listen: false).weightUnit ==
                  WeightUnit.lbs
              ? setData[index].weight.lbs.toString()
              : setData[index].weight.kg.toString();
      repsController.text = setData[index].reps.toString();
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          // all the messy paddings lmao
          titlePadding: EdgeInsets.only(top: 16.0, left: 16.0),
          contentPadding:
              EdgeInsets.only(top: 16.0, right: 16.0, bottom: 0.0, left: 16.0),
          actionsPadding: EdgeInsets.only(top: 0),
          //
          title: Text(
            isEdit ? "Edit Set #${index + 1}" : "Add Set",
            style: isThemeDark(context)
                ? DialogTitleStyle.dark
                : DialogTitleStyle.light,
          ),
          content: Form(
            key: formKey1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  focusNode: weight,
                  autofocus: isEdit ? false : true,
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Weight",
                    suffix: Text(
                        Provider.of<UnitsNotifier>(context).weightUnit ==
                                WeightUnit.kg
                            ? "Kg"
                            : "Lbs"),
                  ),
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
                    border: OutlineInputBorder(),
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
                style: isThemeDark(context)
                    ? DialogActionNegative.dark
                    : DialogActionNegative.light,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(
                isEdit ? "UPDATE" : "ADD",
                style: isThemeDark(context)
                    ? DialogActionPositive.dark
                    : DialogActionPositive.light,
              ),
              onPressed: () {
                isEdit ? updateSet(index) : addSet();
              },
            ),
          ],
        );
      },
    );
  }

//Build the list of sets
  Widget buildSetList(List<Data> setsData) {
    return Column(
      children: [
        for (var i = 0; i < setsData.length; i++)
          Container(
            child: PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onSelected: (value) {
                if (value == 'edit')
                  showSetsInputDialog(
                      index: i, isEdit: true, setData: setsData);
                else
                  deleteSet(i);
              },
              tooltip: 'Show options',
              child: Row(
                children: [
                  Text(
                    "#${(i + 1).toString()}  ",
                    style: isThemeDark(context)
                        ? SetListCount.dark
                        : SetListCount.light,
                  ),
                  Text(
                    Provider.of<UnitsNotifier>(context).weightUnit ==
                            WeightUnit.kg
                        ? setsData[i].weight.kg.toString()
                        : setsData[i].weight.lbs.toString(),
                    style: isThemeDark(context)
                        ? SetListValue.dark
                        : SetListValue.light,
                  ),
                  Text(
                    Provider.of<UnitsNotifier>(context).weightUnit ==
                            WeightUnit.kg
                        ? " Kg"
                        : " Lbs",
                    style: isThemeDark(context)
                        ? SetListText.dark
                        : SetListText.light,
                  ),
                  Text(
                    " for ",
                    style: isThemeDark(context)
                        ? SetListText.dark
                        : SetListText.light,
                  ),
                  Text(
                    "${setsData[i].reps} ",
                    style: isThemeDark(context)
                        ? SetListValue.dark
                        : SetListValue.light,
                  ),
                  Text("Reps",
                      style: isThemeDark(context)
                          ? SetListText.dark
                          : SetListText.light),
                ],
              ),
              itemBuilder: (context) {
                return <PopupMenuItem>[
                  PopupMenuItem(
                    child: Text(
                      'EDIT',
                      style: isThemeDark(context)
                          ? PopupMenuNegative.dark
                          : PopupMenuNegative.light,
                    ),
                    value: 'edit',
                  ),
                  PopupMenuItem(
                    child: Text(
                      'DELETE',
                      style: isThemeDark(context)
                          ? PopupMenuPositive.dark
                          : PopupMenuPositive.light,
                    ),
                    value: 'delete',
                  ),
                ];
              },
            ),
          ),
      ],
    );
  }
}
