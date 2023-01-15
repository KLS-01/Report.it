import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/operatoreCUP_entity.dart';
import 'package:report_it/domain/entity/prenotazione_entity.dart';
import 'package:report_it/domain/entity/super_utente.dart';
import 'package:report_it/domain/entity/tipo_utente.dart';
import 'package:report_it/domain/repository/prenotazione_controller.dart';
import 'package:report_it/presentation/widget/lista_prenotazioni_widget.dart';
import 'package:report_it/presentation/widget/prenotazioni_stream_builder.dart';

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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey2 =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey3 =
      GlobalKey<RefreshIndicatorState>();

  OperatoreCUP? op;
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
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(text: "In attesa"),
                  Tab(text: "Prese in carico"),
                  Tab(text: "Storico"),
                ],
              ),
              title: const Text('Prenotazioni'),
            ),
            body: TabBarView(
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
