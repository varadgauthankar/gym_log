import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker/utils/colors.dart';
import 'package:workout_tracker/utils/helpers.dart';
import 'package:workout_tracker/utils/textStyles.dart';
import 'package:workout_tracker/utils/theme.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool selected = false;
  List<String> darkThemeChips = ['On', 'Off', 'Follow System'];
  List<String> weightChips = ['Kg', 'Lbs'];

  String darkThemeChoice = "";
  String weightChoice = "";

  void changeTheme(String theme) {
    print('in theme changer with: $theme');

    Provider.of<ThemeNotifier>(context, listen: false).toggleTheme(theme);
  }

  List<Widget> buildDarkModeChoices() {
    List<Widget> choices = [];
    darkThemeChips.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: darkThemeChoice == item,
          onSelected: (selected) {
            setState(() {
              darkThemeChoice = item;
              changeTheme(darkThemeChoice);
            });
          },
        ),
      ));
    });
    return choices;
  }

  List<Widget> buildWeightChoices() {
    List<Widget> choices = [];
    weightChips.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: weightChoice == item,
          onSelected: (selected) {
            setState(() {
              weightChoice = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  setDarkmodeChipValue() {
    var notifier = Provider.of<ThemeNotifier>(context, listen: false);
    ThemeMode theme = notifier.theme;
    darkThemeChoice = notifier.convertThemeModeDataToString(theme);
  }

  Color getOverLayColor(BuildContext context, Color color) {
    return Color.alphaBlend(ElevationOverlay.overlayColor(context, 1), color);
  }

  @override
  void initState() {
    setDarkmodeChipValue();
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

// class ChoiceChipWidget extends StatefulWidget {
//   final List<String> reportList;

//   ChoiceChipWidget(this.reportList);

//   @override
//   _ChoiceChipWidgetState createState() => _ChoiceChipWidgetState();
// }

// class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       children: _buildChoiceList(),
//     );
//   }
// }
