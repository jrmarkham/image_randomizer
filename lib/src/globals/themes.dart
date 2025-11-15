import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  // Add other light theme properties

    buttonTheme: ButtonThemeData(
      buttonColor: Colors.yellowAccent,
    )

);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.indigo,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.deepOrange,
  )
  // Add other dark theme properties
);