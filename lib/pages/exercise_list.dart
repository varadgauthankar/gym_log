import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/db/moor_db.dart';
import 'package:workout_tracker/pages/exercise_details.dart';
import 'package:workout_tracker/utils/colors.dart';
import 'package:workout_tracker/utils/date_picker.dart';
import 'package:workout_tracker/utils/textStyles.dart';
import 'package:workout_tracker/widgets/card.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracker/utils/helpers.dart';

class ExerciseList extends StatefulWidget {
  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  final String dateToday = DateFormat("EEEE, d").format(DateTime.now());

  DateTime date = DateTime.now();

  //get the date
  void getExerciseOnDate() async {
    DateTime newDate = await selectDate(context, date);
    setState(() {
      date = newDate.add(Duration(days: 1)).subtract(Duration(seconds: 1));
    });
  }

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isThemeDark(context) ? MyColors.darkGrey : MyColors.white,
      appBar: AppBar(
          // backgroundColor: MyColors.accentColor,
          elevation: 2,
          title: Hero(
            tag: 'appBarTitle',
            child: Material(
              color: Colors.transparent,
              child: Text(
                DateFormat('EEE, d').format(date),
                style: AppBarTitleStyle.dark,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                themeMode(context) == ThemeMode.dark
                    ? Icons.brightness_5_rounded
                    : themeMode(context) == ThemeMode.light
                        ? Icons.brightness_4_rounded
                        : Icons.brightness_auto_rounded,
                color: MyColors.white,
              ),
              tooltip: 'Select date',
              onPressed: () {
                EasyDynamicTheme.of(context).changeTheme();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.calendar_today_rounded,
                color: MyColors.white,
              ),
              tooltip: 'Select date',
              onPressed: () {
                getExerciseOnDate();
              },
            ),
          ]),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: buildExerciseList(context),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        elevation: 3.0,
        child: Icon(Icons.add),
        // foregroundColor: MyColors.black,
        // backgroundColor: MyColors.accentColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExerciseDetail(
                isEdit: false,
                exercise: null,
                date: date,
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
              padding: EdgeInsets.all(6.0),
              itemCount: exercises.length,
              itemBuilder: (_, index) {
                final exercise = exercises[index];
                return ExerciseCard(
                  exercise: exercise,
                  index: index,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/no_data.png',
                    height: 150.0,
                    width: 150.0,
                  ),
                  SizedBox(height: 12),
                  Text('No exercises yet!',
                      style: isThemeDark(context)
                          ? NoDataHeading.dark
                          : NoDataHeading.light),
                  Text('click  +  to add the exercise',
                      style: isThemeDark(context)
                          ? NoDataSubtitle.dark
                          : NoDataSubtitle.light),
                ],
              ),
            );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
