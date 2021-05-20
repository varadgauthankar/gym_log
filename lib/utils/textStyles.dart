import 'package:flutter/material.dart';
import 'package:workout_tracker/utils/colors.dart';

class AppBarTitleStyle {
  static const light = TextStyle(
    color: MyColors.white,
    fontSize: 30.0,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w800,
  );

  static const dark = TextStyle(
    color: MyColors.black,
    fontSize: 30.0,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w800,
  );
}

class CardTitleStyle {
  static const darkLight = TextStyle(
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
    color: MyColors.black,
    fontSize: 22.0,
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
}

class AddSetButtonStyle {
  static const light = TextStyle(
    color: MyColors.darkGrey,
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
    height: 1.2,
  );
}

class SetListValue {
  static const light = TextStyle(
    color: MyColors.accentColor,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    height: 1.2,
  );
}

class SetListText {
  static const light = TextStyle(
    color: MyColors.black,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    height: 1.2,
  );
}

//Dialoge styles
class DialogTitleStyle {
  static const light = TextStyle(
    color: MyColors.black,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
  );
}

class DialogActionPositive {
  static const light = TextStyle(
    color: MyColors.accentColor,
  );
}

class DialogActionNegative {
  static const light = TextStyle(
    color: MyColors.lightGrey,
  );
}
