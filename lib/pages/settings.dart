import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/utils/colors.dart';
import 'package:workout_tracker/utils/enums.dart';
import 'package:workout_tracker/utils/helpers.dart';
import 'package:workout_tracker/utils/textStyles.dart';
import 'package:workout_tracker/utils/theme.dart';
import 'package:workout_tracker/utils/units.dart';

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
          label: Text(describeEnum(item)),
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
          label: Text(describeEnum(item)), //converts enum to string.
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

  // get the color of the overlay widget, just some material rules.
  Color getOverLayColor(BuildContext context, Color color) {
    return Color.alphaBlend(ElevationOverlay.overlayColor(context, 1), color);
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
              "Settings",
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
          Container(
            margin: EdgeInsets.all(6.0),
            child: Material(
              elevation: 3,
              color: isThemeDark(context)
                  ? getOverLayColor(context, MyColors.darkGrey)
                  : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(8.0),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Apperance',
                          style: isThemeDark(context)
                              ? SettingsHeadingStyle.dark
                              : SettingsHeadingStyle.light,
                        ),
                        SizedBox(height: 12.0),
                        Text('Dark Mode'),
                        Wrap(
                          children: buildDarkModeChoices(),
                        ),
                      ]),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(6.0),
            child: Material(
              elevation: 3,
              color: isThemeDark(context)
                  ? getOverLayColor(context, MyColors.darkGrey)
                  : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(8.0),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Units',
                          style: isThemeDark(context)
                              ? SettingsHeadingStyle.dark
                              : SettingsHeadingStyle.light,
                        ),
                        SizedBox(height: 12.0),
                        Text('Weight'),
                        Wrap(
                          children: buildWeightChoices(),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
