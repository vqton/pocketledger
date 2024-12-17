// lib/themes.dart
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    color: Colors.blueAccent,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blueAccent,
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent),
    ),
    labelStyle: TextStyle(color: Colors.blueAccent),
  ),
);
