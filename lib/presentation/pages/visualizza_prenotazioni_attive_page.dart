import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/prenotazione_entity.dart';
import 'package:report_it/domain/entity/super_utente.dart';
import 'package:report_it/domain/entity/tipo_utente.dart';
import 'package:report_it/domain/repository/prenotazione_controller.dart';
import 'package:report_it/presentation/lista_prenotazioni_widget.dart';

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
  PrenotazioneController controller = PrenotazioneController();

  @override
  void initState() {
    super.initState();
  }

  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream;

    return Column(children: [
      Expanded(
        child: Consumer<SuperUtente?>(builder: (context, utente, child) {
          if (utente == null) {
            return const Text("Errore non sei loggato");
          } else {
            if (utente.tipo == TipoUtente.UffPolGiud) {
              return const Text(
                  "Non hai l'autorizzazione per visualizzare la pagina");
            } else {
              stream = streamGenerator(utente);
            }

            return Column(children: [
              if (utente.tipo == TipoUtente.Utente)
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(context);
                      },
                      child: const Text("Prenota")),
                ),
              const Padding(
                padding: EdgeInsets.only(top: 150),
                child: Text("Prenotazioni attive"),
              ),
              Expanded(
                flex: 1,
                child: StreamBuilder(
                  stream: stream,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasError) {
                      print("Errore snapshot");
                    } else {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Text('No data');

                        case ConnectionState.waiting:
                          return Text('Awaiting...');

                        case ConnectionState.active:
                          List<Prenotazione>? listaPrenotazioni =
                              snapshot.data?.docs.map((e) {
                            print("FLAG");

                            return Prenotazione.fromJson(e.data());
                          }).toList();

                          return PrenotazioneListWidget(
                            snapshot: listaPrenotazioni,
                            utente: utente,
                          );

                        case ConnectionState.done:
                          List<Prenotazione>? listaPrenotazioni = snapshot
                              .data?.docs
                              .map((e) => controller.prenotazioneFromJson(e))
                              .toList();
                          print(listaPrenotazioni);

                          return PrenotazioneListWidget(
                            snapshot: listaPrenotazioni,
                            utente: utente,
                          );
                      }
                    }
                    return Text("");
                  },
                ),
              ),
            ]);
          }
        }),
      ),
    ]);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>
      generaStreamPrenotazioniAttiveUtente(SuperUtente? utente) {
    return controller.generaStreamAttive();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> generaStreamPrenotazioniAttive(
      SuperUtente? utente) {
    return controller.generaStreamAttive();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamGenerator(
      SuperUtente utente) {
    if (utente.tipo == TipoUtente.Utente) {
      return generaStreamPrenotazioniAttiveUtente(utente);
    } else if (utente.tipo == TipoUtente.OperatoreCup) {
      return generaStreamPrenotazioniAttive(utente);
    } else {
      throw (NullThrownError());
    }
  }
}
