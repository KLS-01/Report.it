import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/prenotazione_entity.dart';
import 'package:report_it/domain/entity/super_utente.dart';
import 'package:report_it/domain/entity/tipo_utente.dart';
import 'package:report_it/domain/repository/prenotazione_controller.dart';
import 'package:report_it/presentation/lista_prenotazioni_widget.dart';
import 'visualizza_prenotazioni_attive_page.dart';

Color? containerColor;
List<Color> containerColors = [
  const Color(0xFFFDE1D7),
  const Color(0xFFE4EDF5),
  const Color(0xFFE7EEED),
  const Color(0xFFF4E4CE),
];

class VisualizzaPrenotazioniPage extends StatefulWidget {
  const VisualizzaPrenotazioniPage({Key? key}) : super(key: key);

  @override
  State<VisualizzaPrenotazioniPage> createState() =>
      _VisualizzaPrenotazioniPageState();
}

class _VisualizzaPrenotazioniPageState
    extends State<VisualizzaPrenotazioniPage> {
  late Future<List<Prenotazione>> prenotazioni;
  PrenotazioneController controller = PrenotazioneController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey1 =
      GlobalKey<RefreshIndicatorState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey2 =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SuperUtente? utente = context.watch<SuperUtente?>();
    Stream<QuerySnapshot<Map<String, dynamic>>> stream;

    if (utente == null) {
      return const Text("Errore non sei loggato");
    } else {
      if (utente.tipo == TipoUtente.UffPolGiud) {
        return const Text(
            "Non hai l'autorizzazione per visualizzare la pagina");
      }
      return Scaffold(
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(text: "Attive"),
                  Tab(text: "Storico"),
                ],
              ),
              title: const Text('Prenotazioni'),
            ),
            body: TabBarView(
              children: [
                Column(
                  children: [
                    Builder(builder: (context) {
                      stream = streamGeneratorAttive(utente);
                      return Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                                child: RefreshIndicator(
                                    key: _refreshIndicatorKey1,
                                    onRefresh: _pullRefresh,
                                    child: StreamBuilder(
                                        stream: stream,
                                        builder:
                                            (BuildContext context, snapshot) {
                                          if (snapshot.hasError) {
                                            print("Errore snapshot");
                                          } else {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.none:
                                                return Text('No data');

                                              case ConnectionState.waiting:
                                                return Text('Awaiting...');

                                              case ConnectionState.active:
                                                List<Prenotazione>?
                                                    listaPrenotazioni = snapshot
                                                        .data?.docs
                                                        .map((e) {
                                                  print("FLAG");

                                                  return Prenotazione.fromJson(
                                                      e.data());
                                                }).toList();

                                                return PrenotazioneListWidget(
                                                  snapshot: listaPrenotazioni,
                                                  utente: utente,
                                                );

                                              case ConnectionState.done:
                                                List<Prenotazione>?
                                                    listaPrenotazioni = snapshot
                                                        .data?.docs
                                                        .map((e) => controller
                                                            .prenotazioneFromJson(
                                                                e))
                                                        .toList();
                                                print(listaPrenotazioni);

                                                return PrenotazioneListWidget(
                                                  snapshot: listaPrenotazioni,
                                                  utente: utente,
                                                );
                                            }
                                          }
                                          return Text("AAAA");
                                        }))),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
                Builder(builder: (context) {
                  stream = streamGeneratorStorico(utente);

                  return Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                child: RefreshIndicator(
                                    key: _refreshIndicatorKey2,
                                    onRefresh: _pullRefresh,
                                    child: StreamBuilder(
                                        stream: stream,
                                        builder:
                                            (BuildContext context, snapshot) {
                                          if (snapshot.hasError) {
                                            print("Errore snapshot");
                                          } else {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.none:
                                                return Text('No data');

                                              case ConnectionState.waiting:
                                                return Text('Awaiting...');

                                              case ConnectionState.active:
                                                List<Prenotazione>?
                                                    listaPrenotazioni = snapshot
                                                        .data?.docs
                                                        .map((e) {
                                                  print("FLAG");

                                                  return Prenotazione.fromJson(
                                                      e.data());
                                                }).toList();

                                                return PrenotazioneListWidget(
                                                  snapshot: listaPrenotazioni,
                                                  utente: utente,
                                                );

                                              case ConnectionState.done:
                                                List<Prenotazione>?
                                                    listaPrenotazioni = snapshot
                                                        .data?.docs
                                                        .map((e) => controller
                                                            .prenotazioneFromJson(
                                                                e))
                                                        .toList();
                                                print(listaPrenotazioni);

                                                return PrenotazioneListWidget(
                                                  snapshot: listaPrenotazioni,
                                                  utente: utente,
                                                );
                                            }
                                          }
                                          return Text("AAAA");
                                        })),
                              ),
                            ],
                          )),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      );
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamGeneratorAttive(
      SuperUtente utente) {
    if (utente.tipo == TipoUtente.Utente) {
      return controller.generaStreamAttiveUtente(utente);
    } else if (utente.tipo == TipoUtente.OperatoreCup) {
      return controller.generaStreamAttive();
    } else {
      throw (NullThrownError());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamGeneratorStorico(
      SuperUtente utente) {
    if (utente.tipo == TipoUtente.Utente) {
      return controller.generaStreamStoricoUtente(utente);
    } else if (utente.tipo == TipoUtente.OperatoreCup) {
      return controller.generaStreamStoricoOperatore(utente);
    } else {
      throw (NullThrownError());
    }
  }

  Future<void> _pullRefresh() async {
    //Future<List<Prenotazione>> freshList = listGenerator(globalUser);
    setState(() {
      //prenotazioni = freshList;
    });
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAA");
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }
}
