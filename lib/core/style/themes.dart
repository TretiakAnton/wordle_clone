import 'package:flutter/material.dart';

///i'm not designer so colors are quite randomly
class WordleTheme {
  // Light Theme
  static final lightThemeData = ThemeData(
    primaryColor: Colors.deepPurple,
    secondaryHeaderColor: Colors.deepPurpleAccent,
    canvasColor: Colors.black,
    hoverColor:Colors.grey[300],
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.deepPurple,
    ),
    brightness: Brightness.light,
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        color: Colors.black,
        fontSize: 30,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 22,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      bodySmall: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
    ),
  );

  // Dark Theme
  static final darkThemeData = ThemeData(
    primaryColor: Colors.deepPurple,
    secondaryHeaderColor: Colors.pinkAccent,
    canvasColor: Colors.grey[50],
    hoverColor: Colors.grey[700],
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: const AppBarTheme(
      color: Colors.deepPurple,
    ),
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        color: Colors.white,
        fontSize: 30,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 22,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
    ),
  );
}
