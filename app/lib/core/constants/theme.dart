import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    fontFamily: 'Colfax',
    primarySwatch: Colors.grey,
    backgroundColor: Color(0xFFE0E0E0),
    primaryColor: Color(0xFFB41EB3),
    accentColor: Color(0xFFDA1993),
    hintColor: Color(0xFFB8BBC6),
    errorColor: Colors.red[600],
    appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(color: Color(0xFFB41EB3)),
        textTheme: TextTheme(
            headline6: TextStyle(
                color: Color(0xFFB41EB3), fontWeight: FontWeight.w500)),
        iconTheme: IconThemeData(color: Color(0xFFB41EB3))));

final darkTheme = ThemeData(
    fontFamily: 'Colfax',
    backgroundColor: Color(0xFF022b35),
    primaryColor: Color(0xFF0fb7e2),
    primaryColorDark: Colors.black,
    accentColor: Color(0xFF008eb2),
    hintColor: Color(0xFFB8BBC6),
    errorColor: Colors.red[600],
    disabledColor: Colors.grey[300],
    iconTheme: new IconThemeData(color: Colors.grey[300]),
    textTheme: TextTheme(
      bodyText2: TextStyle(color: Colors.white),
      bodyText1: TextStyle(color: Colors.white),
      headline6: TextStyle(color: Colors.white),
    ),
    appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(color: Color(0xFF008eb2)),
        textTheme: TextTheme(
            headline6: TextStyle(
                color: Color(0xFF008eb2), fontWeight: FontWeight.w500)),
        iconTheme: IconThemeData(color: Color(0xFF008eb2))));

class Constants {
  static double padding = 10.0;
  static double doublePadding = 16.0;
  static double borderRadius = 7.0;
  static OutlineInputBorder inputBorders =
      OutlineInputBorder(borderRadius: BorderRadius.circular(7.0));
}
