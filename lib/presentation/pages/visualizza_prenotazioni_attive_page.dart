import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/prenotazione_entity.dart';
import 'package:report_it/domain/entity/super_utente.dart';
import 'package:report_it/domain/entity/tipo_utente.dart';
import 'package:report_it/domain/repository/prenotazione_controller.dart';
import 'package:report_it/presentation/lista_prenotazioni_widget.dart';
import 'test_prenotazioni.dart';
import 'visualizza_storico_prenotazioni_page.dart';

Color? containerColor;
List<Color> containerColors = [
  const Color(0xFFFDE1D7),
  const Color(0xFFE4EDF5),
  const Color(0xFFE7EEED),
  const Color(0xFFF4E4CE),
];

class VisualizzaPrenotazioniAttivePage extends StatefulWidget {
  const VisualizzaPrenotazioniAttivePage({Key? key}) : super(key: key);

  @override
  State<VisualizzaPrenotazioniAttivePage> createState() =>
      _VisualizzaPrenotazioniAttivePageState();
}

class _VisualizzaPrenotazioniAttivePageState
    extends State<VisualizzaPrenotazioniAttivePage> {
  late Future<List<Prenotazione>> prenotazioni;
  late SuperUtente globalUser;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _pullRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attive'),
      ),
      body: Column(children: [
        Expanded(
          child: Consumer<SuperUtente?>(builder: (context, utente, child) {
            if (utente == null) {
              return const Text("Errore non sei loggato");
            } else {
              if (utente.tipo == TipoUtente.UffPolGiud) {
                return const Text(
                    "Non hai l'autorizzazione per visualizzare la pagina");
              } else {
                prenotazioni = listGenerator(utente);
              }
              globalUser = utente;
              return Column(children: [
                if (utente.tipo == TipoUtente.Utente)
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop(context);
                        },
                        child: const Text("Prenota")),
                  ),
                const Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Text("Prenotazioni attive"),
                ),
                Expanded(
                    flex: 1,
                    child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: _pullRefresh,
                      child: FutureBuilder<List<Prenotazione>>(
                        future: prenotazioni,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Prenotazione>> snapshot) {
                          return PrenotazioneListWidget(
                              snapshot: snapshot, utente: utente);
                        },
                      ),
                    )),
              ]);
            }
          }),
        ),
        ElevatedButton(onPressed: _pullRefresh, child: Text("AAA"))
      ]),
    );
  }

  Future<List<Prenotazione>> generaListaPrenotazioniAttiveUtente(
      SuperUtente? utente) {
    PrenotazioneController controller = PrenotazioneController();
    return controller.visualizzaAttiveByUtente(utente);
  }

  Future<List<Prenotazione>> generaListaPrenotazioniAttive(
      SuperUtente? utente) {
    PrenotazioneController controller = PrenotazioneController();
    print(utente!.id);
    return controller.visualizzaAttive(utente);
  }

  Future<List<Prenotazione>> listGenerator(SuperUtente utente) {
    if (utente.tipo == TipoUtente.Utente) {
      return generaListaPrenotazioniAttiveUtente(utente);
    } else if (utente.tipo == TipoUtente.OperatoreCup) {
      return generaListaPrenotazioniAttive(utente);
    } else {
      throw (NullThrownError());
    }
  }

  Future<void> _pullRefresh() async {
    Future<List<Prenotazione>> freshList = listGenerator(globalUser);
    setState(() {
      prenotazioni = freshList;
    });
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAA");
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }
}
