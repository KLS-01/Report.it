import 'package:flutter/material.dart';
import 'package:report_it/presentation/pages/pages_GG/geolocalizzazione_page.dart';
import 'package:report_it/presentation/pages/pages_GIC/Informativa_contatti_page.dart';
import 'package:report_it/presentation/pages/pages_GF/forum_home_page.dart';
import 'package:report_it/presentation/pages/pages_GPSP/inoltro_prenotazione_page.dart';
import 'package:report_it/presentation/pages/pages_GPSP/psicologo_home_page.dart';
import 'package:report_it/presentation/pages/pages_GD/visualizza_storico_denunce_page.dart';
import 'package:report_it/presentation/pages/pages_GPSP/visualizza_prenotazioni_page.dart';
import 'package:report_it/presentation/widget/geo_provider_widget.dart';

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
      child = GeolocalizationProvider();
    else
      child = VisualizzaPrenotazioni();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
