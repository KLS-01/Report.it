import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GPSP/adapter_prenotazione.dart';
import 'package:report_it/domain/entity/entity_GPSP/prenotazione_entity.dart';
import 'package:report_it/domain/repository/prenotazione_controller.dart';
import 'package:report_it/presentation/widget/lista_prenotazioni_widget.dart';

enum Mode { storico, inCarico, inAttesa }

// ignore: must_be_immutable
class PrenotazioneStreamWidget extends StatefulWidget {
  Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  final SuperUtente utente;
  final Mode mode;

  PrenotazioneStreamWidget({
    super.key,
    required this.stream,
    required this.utente,
    required this.mode,
  });

  @override
  State<PrenotazioneStreamWidget> createState() =>
      _PrenotazioneStreamWidgetState(
          stream: stream, utente: utente, mode: mode);
}

class _PrenotazioneStreamWidgetState extends State<PrenotazioneStreamWidget> {
  _PrenotazioneStreamWidgetState({
    required this.stream,
    required this.utente,
    required this.mode,
  });
  @override
  void initState() {
    super.initState();
  }

  late Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  PrenotazioneController controller = PrenotazioneController();
  final SuperUtente utente;
  final Mode mode;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream = widget.stream;
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                      stream: stream,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasError) {
                          print("Errore snapshot");
                        } else {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return const Text('No data');
                            case ConnectionState.waiting:
                              return const Text('Awaiting...');
                            case ConnectionState.active:
                              break;
                            case ConnectionState.done:
                              break;
                          }
                          if (snapshot.connectionState ==
                                  ConnectionState.active ||
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            List<Prenotazione>? listaPrenotazioni =
                                snapshot.data?.docs.map((e) {
                              Prenotazione p =
                                  AdapterPrenotazione().fromJson(e.data());
                              return p;
                            }).toList();
                            print(listaPrenotazioni);
                            listaPrenotazioni = listFilter(listaPrenotazioni);

                            return PrenotazioneListWidget(
                                snapshot: listaPrenotazioni,
                                utente: utente,
                                update: _pullRefresh);
                          }
                        }
                        return Text("AAAA");
                      }),
                ),
              ],
            )),
      ],
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {});
  }

  List<Prenotazione>? listFilter(List<Prenotazione>? listaPrenotazioni) {
    if (listaPrenotazioni != null) {
      switch (mode) {
        case Mode.storico:
          listaPrenotazioni.removeWhere((element) =>
              element.getDataPrenotazione == null ||
              DateTime.now().isBefore(element.getDataPrenotazione.toDate()));
          break;
        case Mode.inCarico:
          listaPrenotazioni.removeWhere((element) =>
              element.getDataPrenotazione == null ||
              element.dataPrenotazione!.toDate().isBefore(DateTime.now()));

          break;
        case Mode.inAttesa:
          listaPrenotazioni
              .removeWhere((element) => element.getDataPrenotazione != null);
          break;
      }
    }
    return listaPrenotazioni;
  }
}
