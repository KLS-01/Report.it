import 'package:flutter/material.dart';

abstract class ThemeText {
  static ThemeData theme = ThemeData(
    backgroundColor: const Color.fromRGBO(255, 254, 248, 1),
    primarySwatch: Colors.red,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  static const TextStyle titoloSezione = TextStyle(
    fontSize: 23,
    fontFamily: 'SourceSerifPro',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle titoloInoltro = TextStyle(
    fontSize: 20,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle corpoInoltro = TextStyle(
    fontSize: 16,
    fontFamily: 'Ubuntu',
    color: Colors.black,
  );
  static const TextStyle titoloAlert = TextStyle(
    fontSize: 16,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(219, 29, 69, 1),
  );
  static ButtonStyle bottoneRosso = ButtonStyle(
    elevation: MaterialStateProperty.all(5),
    textStyle: MaterialStateProperty.all(
      const TextStyle(
        fontSize: 15,
        fontFamily: 'Ubuntu',
        color: Colors.white,
      ),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    backgroundColor: MaterialStateProperty.all(
      const Color.fromRGBO(219, 29, 69, 1),
    ),
  );
}
