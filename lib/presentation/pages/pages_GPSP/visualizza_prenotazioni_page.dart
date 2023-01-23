import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/entity_GA/operatoreCUP_entity.dart';
import 'package:report_it/domain/entity/entity_GA/spid_entity.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/domain/entity/entity_GPSP/prenotazione_entity.dart';
import 'package:report_it/domain/repository/authentication_controller.dart';
import 'package:report_it/domain/repository/prenotazione_controller.dart';
import 'package:report_it/presentation/pages/pages_GPSP/inoltro_prenotazione_page.dart';
import 'package:report_it/presentation/widget/prenotazioni_stream_builder.dart';
import '../../widget/styles.dart';

class VisualizzaPrenotazioni extends StatefulWidget {
  const VisualizzaPrenotazioni({Key? key}) : super(key: key);

  @override
  State<VisualizzaPrenotazioni> createState() => _VisualizzaPrenotazioni();
}

class _VisualizzaPrenotazioni extends State<VisualizzaPrenotazioni> {
  late Future<List<Prenotazione>> prenotazioni;
  PrenotazioneController controller = PrenotazioneController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey2 =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey3 =
      GlobalKey<RefreshIndicatorState>();

  OperatoreCUP? op;

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
        appBar: AppBar(
          title: const Text(
            'Sezione Prenotazione Psicologica',
            style: ThemeText.titoloSezione,
            overflow: TextOverflow.ellipsis,
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
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
              child: TabBarView(
                children: [
                  RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: _pullRefresh,
                    child: Column(
                      children: [
                        Builder(builder: (context) {
                          stream = streamGeneratorAttive(utente);
                          return Expanded(
                            flex: 1,
                            child: PrenotazioneStreamWidget(
                                stream: stream,
                                utente: utente,
                                mode: Mode.inAttesa),
                          );
                        }),
                      ],
                    ),
                  ),
                  RefreshIndicator(
                    key: _refreshIndicatorKey2,
                    onRefresh: _pullRefresh,
                    child: Builder(builder: (context) {
                      stream = streamGeneratorAttive(utente);

                      return PrenotazioneStreamWidget(
                        stream: stream,
                        utente: utente,
                        mode: Mode.inCarico,
                      );
                    }),
                  ),
                  RefreshIndicator(
                    key: _refreshIndicatorKey3,
                    onRefresh: _pullRefresh,
                    child: Builder(builder: (context) {
                      stream = streamGeneratorStorico(utente);

                      return PrenotazioneStreamWidget(
                        stream: stream,
                        utente: utente,
                        mode: Mode.storico,
                      );
                    }),
                  ),
                ],
              ),
            ),
            floatingActionButton: Consumer<SuperUtente?>(
              builder: (context, utente, _) {
                if (utente?.tipo == TipoUtente.Utente) {
                  return FutureBuilder<SPID?>(
                    future: AuthenticationService(FirebaseAuth.instance)
                        .getSpid(utente?.id),
                    builder:
                        (BuildContext context, AsyncSnapshot<SPID?> snapshot) {
                      return FloatingActionButton.extended(
                          backgroundColor: const Color.fromRGBO(219, 29, 69, 1),
                          label: const Text("Prenota"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InoltroPrenotazione(
                                    utente: utente!, spid: snapshot.data!),
                              ),
                            );
                          });
                    },
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

  Stream<QuerySnapshot<Map<String, dynamic>>> streamGeneratorAttive(
      SuperUtente utente) {
    if (utente.tipo == TipoUtente.Utente) {
      return controller.generaStreamAttiveUtente(utente);
    } else if (utente.tipo == TipoUtente.OperatoreCup) {
      return controller.generaStreamAttive(utente);
    } else {
      return const Stream.empty();
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
    print("DFDF");
    setState(() {});
  }
}
