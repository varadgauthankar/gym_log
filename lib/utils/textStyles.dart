import 'package:flutter/material.dart';
import 'package:workout_tracker/utils/colors.dart';

class AppBarTitleStyle {
  static const light = TextStyle(
    color: MyColors.black,
    fontSize: 30.0,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w800,
    decoration: TextDecoration.none,
  );

  static const dark = TextStyle(
    color: MyColors.white,
    fontSize: 30.0,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w800,
    decoration: TextDecoration.none,
  );
}

//card styles
class CardTitleStyle {
  static const light = TextStyle(
    color: MyColors.accentVarientColor,
    fontSize: 28.0,
    fontWeight: FontWeight.w800,
  );
  static const dark = TextStyle(
    color: MyColors.accentColor,
    fontSize: 28.0,
    fontWeight: FontWeight.w800,
  );
}

class CardExNumberStyle {
  static const light = TextStyle(
    color: MyColors.lightGrey,
    fontSize: 24.0,
    fontWeight: FontWeight.w900,
  );
}

class CardSubTitleStyle {
  static const light = TextStyle(
    color: MyColors.darkGrey,
    fontSize: 24.0,
    fontWeight: FontWeight.w900,
  );
  static const dark = TextStyle(
    color: MyColors.white,
    fontSize: 24.0,
    fontWeight: FontWeight.w900,
  );
}

class CardPreNumStyle {
  static const darkLight = TextStyle(
    color: MyColors.lightGrey,
    fontSize: 18.0,
    fontWeight: FontWeight.w900,
    height: 1.2,
  );
}

class CardValueStyle {
  static const light = TextStyle(
    color: MyColors.accentVarientColor,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    height: 1.2,
  );
  static const dark = TextStyle(
    color: MyColors.accentColor,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    height: 1.2,
  );
}

class CardMainStyle {
  static const light = TextStyle(
    color: MyColors.black,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    height: 1.2,
  );
  static const dark = TextStyle(
    color: MyColors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    height: 1.2,
  );
}

class AddSetButtonStyle {
  static const light = TextStyle(
    color: MyColors.darkGrey,
    fontSize: 18.0,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic,
    height: 1.2,
  );
  static const dark = TextStyle(
    color: MyColors.lightGrey,
    fontSize: 18.0,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic,
    height: 1.2,
  );
}

class InputLabelStyle {
  static const light = TextStyle(
    color: MyColors.accentColor,
    fontSize: 18.0,
  );
}

class InputHitnStyle {
  static const light = TextStyle(
    color: MyColors.lightGrey,
    fontSize: 18.0,
  );
}

//set list style

class SetListCount {
  static const light = TextStyle(
    color: MyColors.lightGrey,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    height: 1.5,
  );

  static const dark = TextStyle(
    color: MyColors.lightGrey,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    height: 1.5,
  );
}

class SetListValue {
  static const light = TextStyle(
    color: MyColors.accentVarientColor,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    height: 1.5,
  );
  static const dark = TextStyle(
    color: MyColors.accentColor,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    height: 1.5,
  );
}

class SetListText {
  static const light = TextStyle(
    color: MyColors.black,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    height: 1.5,
  );
  static const dark = TextStyle(
    color: MyColors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    height: 1.5,
  );
}

//Dialoge styles
class DialogTitleStyle {
  static const light = TextStyle(
    color: MyColors.black,
    fontSize: 22.0,
    fontWeight: FontWeight.w800,
  );
  static const dark = TextStyle(
    color: MyColors.white,
    fontSize: 22.0,
    fontWeight: FontWeight.w800,
  );
}

class DialogActionPositive {
  static const light = TextStyle(
    color: MyColors.accentVarientColor,
    fontWeight: FontWeight.bold,
  );
  static const dark = TextStyle(
    color: MyColors.accentColor,
    fontWeight: FontWeight.bold,
  );
}

class DialogActionNegative {
  static const light = TextStyle(
    color: MyColors.darkGrey,
    fontWeight: FontWeight.bold,
  );
  static const dark = TextStyle(
    color: MyColors.lightGrey,
    fontWeight: FontWeight.bold,
  );
}

//popup menu
class PopupMenuPositive {
  static const light = TextStyle(
    color: MyColors.accentVarientColor,
    fontWeight: FontWeight.w600,
  );
  static const dark = TextStyle(
    color: MyColors.accentColor,
    fontWeight: FontWeight.w600,
  );
}

class PopupMenuNegative {
  static const light = TextStyle(
    color: MyColors.black,
    fontWeight: FontWeight.w600,
  );
  static const dark = TextStyle(
    color: MyColors.white,
    fontWeight: FontWeight.w600,
  );
}

//no data image
class NoDataHeading {
  static const light = TextStyle(
    color: MyColors.black,
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
  );
  static const dark = TextStyle(
    color: MyColors.white,
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
  );
}

class NoDataSubtitle {
  static const light = TextStyle(
    color: MyColors.black,
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
    height: 1.3,
  );
  static const dark = TextStyle(
    color: MyColors.white,
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
    height: 1.3,
  );
}
