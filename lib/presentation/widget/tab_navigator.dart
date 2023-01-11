import 'package:flutter/material.dart';
import 'package:report_it/presentation/pages/Informativa_contatti_page.dart';
import 'package:report_it/presentation/pages/forum_home_page.dart';
import 'package:report_it/presentation/pages/mappa_page.dart';
import 'package:report_it/presentation/pages/psicologo_home_page.dart';
import 'package:report_it/presentation/pages/visualizza_prenotazioni_page.dart';
import 'package:report_it/presentation/pages/visualizza_storico_denunce_page.dart';
import 'package:report_it/presentation/pages/visualizza_storico_prenotazioni_page.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == "denuncia")
      child = VisualizzaStoricoDenunceUtentePage();
    else if (tabItem == "forum")
      child = ForumHome();
    else if (tabItem == "informativa")
      child = Informativa();
    else if (tabItem == "mappa")
      child = Mappa();
    else
      child = VisualizzaPrenotazioniPage();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
