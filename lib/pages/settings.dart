import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gym_log/db/moor_db.dart';
import 'package:gym_log/utils/colors.dart';
import 'package:gym_log/utils/enums.dart';
import 'package:gym_log/utils/helpers.dart';
import 'package:gym_log/utils/textStyles.dart';
import 'package:gym_log/utils/theme.dart';
import 'package:gym_log/utils/units.dart';
import 'package:gym_log/widgets/settings_card.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppTheme appTheme;
  WeightUnit weightUnit;

//Build the dark mode chips
  List<Widget> buildDarkModeChoices() {
    List<Widget> choices = [];
    AppTheme.values.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(toBeginningOfSentenceCase(
              describeEnum(item))), //Enum to string, First letter capital
          selected: appTheme == item,
          onSelected: (selected) {
            setState(() {
              appTheme = item;
              toggleAppTheme(appTheme);
            });
          },
        ),
      ));
    });
    return choices;
  }

// build the weight unit chips
  List<Widget> buildWeightChoices() {
    List<Widget> choices = [];

    WeightUnit.values.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(toBeginningOfSentenceCase(
              describeEnum(item))), //Enum to string, First letter capital
          selected: weightUnit == item,
          onSelected: (selected) {
            setState(() {
              weightUnit = item;
              toggleWeightUnits(weightUnit);
            });
          },
        ),
      ));
    });
    return choices;
  }

  // toggle the Apptheme
  void toggleAppTheme(AppTheme appTheme) {
    Provider.of<ThemeNotifier>(context, listen: false).toggleAppTheme(appTheme);
  }

  // Toggle The weights unit
  void toggleWeightUnits(WeightUnit weightUnit) {
    Provider.of<UnitsNotifier>(context, listen: false)
        .toggleWeightUnit(weightUnit);
  }

  //Sets Chips to their respective value
  void setChipValues() {
    appTheme = Provider.of<ThemeNotifier>(context, listen: false).appTheme;
    weightUnit = Provider.of<UnitsNotifier>(context, listen: false).weightUnit;
  }

  @override
  void initState() {
    setChipValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Settings',
              style: AppBarTitleStyle.dark,
            ),
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        padding: EdgeInsets.all(6.0),
        children: [
          SettingsCard(
            title: 'Appearance',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dark Mode'),
                Wrap(children: buildDarkModeChoices()),
              ],
            ),
          ),
          SettingsCard(
            title: 'Units',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Weight'),
                Wrap(children: buildWeightChoices()),
              ],
            ),
          ),
          SettingsCard(
            title: 'Data',
            child: Column(
              children: [
                TextButton(
                  child: Text(
                    'DELETE ALL DATA',
                    style: DeleteDataButton.light,
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: MyColors.black.withOpacity(0.1)),
                  onPressed: deleteAllDataDialog,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void deleteAllDataDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            title: Text('Warning!'),
            content: Text('Really delete all data? This cannot be undone.'),
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
                  Navigator.pop(context);
                  Provider.of<AppDatabase>(context, listen: false)
                      .deleteAllData()
                      .then(
                        (value) => snackBar(context,
                            content: 'Deleted $value Exercise(s)'),
                      );
                },
              )
            ],
          );
        });
  }
}
