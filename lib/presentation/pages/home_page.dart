import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:report_it/presentation/pages/Informativa_contatti.dart';
import 'package:report_it/presentation/pages/fake_index.dart';
import 'package:report_it/presentation/pages/fake_index.dart';
import 'package:report_it/presentation/pages/visualizza_storico_denunce_page.dart';
import '../../domain/repository/authentication_service.dart';
import 'informativa_contatti_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(12);

  int _selectedItemPosition = 2;
  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.black;
  Color unselectedColor = Colors.blueGrey;

  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);
  Gradient unselectedGradient = const LinearGradient(colors: [
    Color.fromARGB(255, 153, 235, 12),
    Color.fromARGB(255, 25, 52, 183)
  ]);

  Color? containerColor;
  List<Color> containerColors = [
    const Color(0xFFFDE1D7),
    const Color(0xFFE4EDF5),
    const Color(0xFFE7EEED),
    const Color(0xFFF4E4CE),
  ];

// questo è l'indice della navbar, da aggiornare ad ogni nuova aggiunta
  final List<Widget> Pagine = [
    const VisualizzaStoricoDenunceUtentePage(),
    Fake_index(),
    Informativa(),
    Fake_index(),
    Fake_index(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      // APPBAR FUNZIONANTE ma attualmente non in uso
      appBar: AppBar(
          centerTitle: true,
          leading:
              Image.asset('assets/images/C11_Logo-png.png', fit: BoxFit.cover),
          title: Text('Report.it', style: TextStyle(color: Colors.black)),
          // IconButton(
          // icon: const Icon(Icons.arrow_back, color: Colors.black),
          // onPressed: () {}),
          //title: const Text('Go back', style: TextStyle(color: Colors.black)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(Iconsax.logout, color: Colors.black))
          ]),
      body: Pagine[_selectedItemPosition],
      bottomNavigationBar: SnakeNavigationBar.color(
        // height: 80,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,

        ///configuration for SnakeNavigationBar.gradient
        // snakeViewGradient: selectedGradient,
        // selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
        // unselectedItemGradient: unselectedGradient,

        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,

        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.document_normal),
            label: 'denunce',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.people),
            label: 'forum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.info_circle),
            label: 'informazioni',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.map),
            label: 'mappa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.health),
            label: 'psicologo',
          )
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}
