// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/entity_GD/stato_denuncia.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/presentation/pages/pages_GPSP/inoltro_prenotazione_page.dart';
import 'package:report_it/presentation/widget/widget_info.dart';
import '../../../domain/entity/entity_GD/denuncia_entity.dart';
import '../../../../domain/repository/denuncia_controller.dart';
import '../../widget/styles.dart';
import '../../widget/theme.dart';
import '../../widget/visualizza_denunce_widget.dart';

class VisualizzaPrenotazioni extends StatefulWidget {
  const VisualizzaPrenotazioni({Key? key}) : super(key: key);

  @override
  State<VisualizzaPrenotazioni> createState() => _VisualizzaPrenotazioni();
}

class _VisualizzaPrenotazioni extends State<VisualizzaPrenotazioni> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sezione Prenotazione Psicologica',
            style: ThemeText.titoloSezione),
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 254, 248, 1),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Theme.of(context).backgroundColor,
            bottom: const TabBar(
              labelColor: Color.fromRGBO(219, 29, 69, 1),
              indicatorColor: Color.fromRGBO(219, 29, 69, 1),
              tabs: [
                Tab(
                  child: Text(
                    "In attesa",
                    style: TextStyle(fontSize: 15, fontFamily: 'Ubuntu'),
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: Text(
                    "Prese in carico",
                    style: TextStyle(fontSize: 15, fontFamily: 'Ubuntu'),
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: Text(
                    "Storico",
                    style: TextStyle(fontSize: 15, fontFamily: 'Ubuntu'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          floatingActionButton: Consumer<SuperUtente?>(
            builder: (context, utente, _) {
              if (utente?.tipo == TipoUtente.Utente) {
                return FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            InoltroPrenotazione(utente: utente!),
                      ),
                    );
                  },
                  backgroundColor: const Color.fromRGBO(219, 29, 69, 1),
                  child: const Icon(Icons.add),
                );
              } else {
                return Visibility(
                  visible: false,
                  child: FloatingActionButton(onPressed: () {}),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
