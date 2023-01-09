import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:report_it/presentation/pages/informativa_contatti_page.dart';
import 'package:report_it/presentation/pages/fake_index.dart';
import 'package:report_it/presentation/pages/fake_index.dart';
import 'package:report_it/presentation/pages/visualizza_storico_denunce_page.dart';
import '../../domain/entity/super_utente.dart';
import '../../domain/repository/authentication_service.dart';
import 'informativa_contatti_page.dart';
import 'package:report_it/presentation/pages/informativa_contatti_page.dart';
import 'package:report_it/presentation/pages/forum_home_page.dart';
import 'package:report_it/presentation/pages/mappa_page.dart';
import 'package:report_it/presentation/pages/psicologo_home_page.dart';
import 'package:report_it/presentation/pages/visualizza_storico_denunce_page.dart';
import 'package:report_it/presentation/widget/tab_navigator.dart';

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
    const VisualizzaStoricoDenunceUtentePage(),
    Fake_index(),
    Informativa(),
    Mappa(),
    Psicologo(),
  ];

  String _currentPage = "informativa";
  List<String> pageKeys = [
    "denuncia",
    "forum",
    "informativa",
    "mappa",
    "psicologo"
  ];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "denuncia": GlobalKey<NavigatorState>(),
    "forum": GlobalKey<NavigatorState>(),
    "informativa": GlobalKey<NavigatorState>(),
    "mappa": GlobalKey<NavigatorState>(),
    "psicologo": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 2;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "informativa") {
            _selectTab("informativa", 2);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 254, 248, 1),
        appBar: AppBar(
            centerTitle: true,
            leading: Image.asset('assets/images/C11_Logo-png.png',
                fit: BoxFit.cover),
            title: Text('Report.it', style: TextStyle(color: Colors.black)),
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
        body: Stack(children: <Widget>[
          _buildOffstageNavigator("informativa"),
          _buildOffstageNavigator("denuncia"),
          _buildOffstageNavigator("forum"),
          _buildOffstageNavigator("mappa"),
          _buildOffstageNavigator("psicologo"),
        ]),
        bottomNavigationBar: SnakeNavigationBar.color(
          behaviour: snakeBarStyle,
          snakeShape: snakeShape,
          shape: bottomBarShape,
          padding: padding,
          elevation: 8,

          //configuration for SnakeNavigationBar.color
          snakeViewColor: Color.fromRGBO(219, 29, 69, 1), //E' QUESTOOOOOOO
          selectedItemColor:
              snakeShape == SnakeShape.indicator ? selectedColor : null,
          unselectedItemColor: Colors.blueGrey,

          showUnselectedLabels: showUnselectedLabels,
          showSelectedLabels: showSelectedLabels,

          currentIndex: _selectedIndex,
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
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
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
