import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gym_log/db/moor_db.dart';
import 'package:gym_log/pages/exercise_details.dart';
import 'package:gym_log/pages/settings.dart';
import 'package:gym_log/utils/colors.dart';
import 'package:gym_log/utils/date_picker.dart';
import 'package:gym_log/utils/textStyles.dart';
import 'package:gym_log/widgets/empty_page.dart';
import 'package:gym_log/widgets/exercise_card.dart';
import 'package:intl/intl.dart';
import 'package:gym_log/utils/helpers.dart';

class ExerciseList extends StatefulWidget {
  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  DateTime date = DateTime.now();

  //get the date
  void getExerciseOnDate() async {
    DateTime newDate = await selectDate(context, date);
    if (newDate != null)
      setState(() {
        date = newDate.add(Duration(days: 1)).subtract(Duration(seconds: 1));
      });
  }

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
                Icons.calendar_today_rounded,
                color: MyColors.white,
              ),
              tooltip: 'Select date',
              onPressed: () => getExerciseOnDate(),
            ),
            IconButton(
              icon: Icon(
                Icons.settings_rounded,
                color: MyColors.white,
              ),
              tooltip: 'Settings',
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage())),
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
            return EmptyPage();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
