import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/presentation/pages/pages_GPSP/inoltro_prenotazione_page.dart';
import '../../widget/styles.dart';

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
        backgroundColor: const Color.fromRGBO(255, 254, 248, 1),
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
                    style: ThemeText.titoloTab,
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: Text(
                    "Prenotate",
                    style: ThemeText.titoloTab,
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: Text(
                    "Storico",
                    style: ThemeText.titoloTab,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: Container(
            color: Theme.of(context).backgroundColor,
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
