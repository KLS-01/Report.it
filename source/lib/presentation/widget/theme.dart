import 'package:flutter/material.dart';

class AppTheme {
  AppTheme() {
    build();
  }

  ThemeData? build() {
    return ThemeData(
      backgroundColor: const Color.fromRGBO(255, 254, 248, 1),
      primarySwatch: Colors.red,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 40,
          fontFamily: 'SourceSerifPro',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headline2: TextStyle(
          fontSize: 25,
          fontFamily: 'IconFont',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headline3: TextStyle(
          fontSize: 20,
          fontFamily: 'SourceSerifPro',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyText1: TextStyle(
          fontSize: 20,
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.w200,
          color: Colors.black,
        ),
        bodyText2: TextStyle(
          fontSize: 15,
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.w200,
          color: Colors.black,
        ),
      ),
    );
  }
}
