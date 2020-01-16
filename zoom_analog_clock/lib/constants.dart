import 'package:flutter/material.dart';

class Constants {
  static const POINT_OFFSET = 100.0;
  static const GRAVITY_CENTER_OFFSET = 100.0;
  static const NUMBER_OFFSET = 25.0;
  static const HOUR_ANGLE_IN_DEGREE = 30.0;
  static const HOURS = 12;
  static const QUARTERS = 4.0;
  static const BIG_BULLET_SIZE = 3.5;
  static const SMALL_BULLET_SIZE = 3.0;
  static const ZOOM_SCALE = 4.0;

  static final defaultTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 25,
    color: Colors.black,
  );

  static final lightTheme = ThemeData(
    accentColor: Color(0xffff5e2b),
    primaryColor: Colors.black,
    secondaryHeaderColor: Color(0x80d8d8d8),
    highlightColor: Colors.black,
    backgroundColor: Colors.white,
    textTheme: TextTheme(
      display1: defaultTextStyle,
    ),
  );

  static final darkTheme = ThemeData(
    accentColor: Color(0xffff5e2b),
    primaryColor: Colors.white,
    secondaryHeaderColor: Color(0x80d8d8d8),
    highlightColor: Color(0xffd8d8d8),
    backgroundColor: Colors.black,
    textTheme: TextTheme(
      display1: defaultTextStyle.copyWith(color: Colors.white),
    ),
  );
}
