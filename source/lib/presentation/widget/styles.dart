import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor coloriPalette = MaterialColor(
    0xFFDB1D45, // 0%
    <int, Color>{
      50: Color(0xFFDB1D45), //10%
      100: Color(0xFFDB1D45), //20%
      200: Color(0xFFDB1D45), //30%
      300: Color(0xFFDB1D45), //40%
      400: Color(0xFFDB1D45), //50%
      500: Color(0xFFDB1D45), //60%
      600: Color(0xFFDB1D45), //70%
      700: Color(0xFFDB1D45), //80%
      800: Color(0xFFDB1D45), //90%
      900: Color(0xFFDB1D45), //100%
    },
  );
} //

abstract class ThemeText {
  static ThemeData theme = ThemeData(
    backgroundColor: const Color.fromRGBO(255, 254, 248, 1),
    primarySwatch: Palette.coloriPalette,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static const TextStyle titoloGIC = TextStyle(
    fontSize: 40,
    fontFamily: 'Merriweather',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle corpoGIC = TextStyle(
    fontSize: 20,
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w200,
    color: Colors.black,
  );
  static const TextStyle titoloSezione = TextStyle(
    fontSize: 23,
    fontFamily: 'Merriweather',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle titoloTab = TextStyle(
    fontSize: 15,
    fontFamily: 'Merriweather',
    fontWeight: FontWeight.bold,
  );
  static const TextStyle titoloInoltro = TextStyle(
    fontSize: 20,
    fontFamily: 'Raleway',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle corpoInoltro = TextStyle(
    fontSize: 16,
    fontFamily: 'Raleway',
    color: Colors.black,
  );
  static const TextStyle chiamataGIC = TextStyle(
    fontSize: 20,
    fontFamily: 'Raleway',
  );
  static const TextStyle titoloDettaglio = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle titoloForum = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle corpoForum = TextStyle(
    fontSize: 15,
    color: Colors.black,
  );

  static const TextStyle titoloAlert = TextStyle(
    fontSize: 17,
    fontFamily: 'Raleway',
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(219, 29, 69, 1),
  );

  static ButtonStyle bottoneRosso = ButtonStyle(
    elevation: MaterialStateProperty.all(5),
    textStyle: MaterialStateProperty.all(
      const TextStyle(
        fontSize: 15,
        fontFamily: 'Raleway',
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

  static BoxDecoration bottoneChiamata = const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    color: Colors.white,
  );

  static BoxDecoration bottoneInAttesa = BoxDecoration(
    color: Colors.amberAccent,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.4),
        blurRadius: 8.0,
        spreadRadius: 1.0,
        offset: const Offset(0, 3),
      ),
    ],
  );
  static BoxDecoration bottoneInCarico = BoxDecoration(
    color: Colors.green,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.4),
        blurRadius: 8.0,
        spreadRadius: 1.0,
        offset: const Offset(0, 3),
      ),
    ],
  );
  static BoxDecoration bottoneChiusa = BoxDecoration(
    color: Colors.grey,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.4),
        blurRadius: 8.0,
        spreadRadius: 1.0,
        offset: const Offset(0, 3),
      ),
    ],
  );
  static BoxDecoration boxDettaglio = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        blurRadius: 8.0,
        spreadRadius: 1.0,
        offset: Offset(0, 3),
      )
    ],
  );

  static BoxDecoration boxVisualizza = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        blurRadius: 8.0,
        spreadRadius: 1.0,
        offset: const Offset(0, 3),
      )
    ],
  );

  static BoxDecoration boxRossoDettaglio = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(
        color: Colors.redAccent,
        blurRadius: 8.0,
        spreadRadius: 1.0,
        offset: Offset(0, 3),
      )
    ],
  );
}
