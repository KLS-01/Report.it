import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:report_it/presentation/pages/informativa_contatti_page.dart';
import 'package:report_it/presentation/pages/forum_home_page.dart';
import 'package:report_it/presentation/pages/mappa_page.dart';
import 'package:report_it/presentation/pages/psicologo_home_page.dart';
import 'denuncia_home_page.dart';

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

// questo è l'indice della navbar, da aggiornare ad ogni nuova aggiunta
  final List<Widget> Pagine = [
    Denunce(),
    Forum(),
    Informativa(),
    Mappa(),
    Psicologo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
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
          backgroundColor: Color.fromRGBO(255, 254, 248, 1),
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
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,
        elevation: 8,

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: Color.fromRGBO(219, 29, 69, 1), //E' QUESTOOOOOOO
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: Colors.blueGrey,

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
