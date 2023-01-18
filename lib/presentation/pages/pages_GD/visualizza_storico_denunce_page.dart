import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/entity_GD/stato_denuncia.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import '../../../domain/entity/entity_GD/denuncia_entity.dart';
import '../../../../domain/repository/denuncia_controller.dart';
import '../../widget/styles.dart';
import 'inoltro_denuncia_page.dart';
import '../../widget/visualizza_denunce_widget.dart';

class VisualizzaStoricoDenunceUtentePage extends StatefulWidget {
  const VisualizzaStoricoDenunceUtentePage({Key? key}) : super(key: key);

  @override
  State<VisualizzaStoricoDenunceUtentePage> createState() =>
      _VisualizzaStoricoDenunceUtentePageState();
}

class _VisualizzaStoricoDenunceUtentePageState
    extends State<VisualizzaStoricoDenunceUtentePage> {
    
  Future<void> _pullRefresh() async {
    setState(() {});
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey1 =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey2 =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey3 =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    SuperUtente? utente = context.watch<SuperUtente?>();
    if (utente?.tipo != TipoUtente.OperatoreCup) {
      Stream<QuerySnapshot<Map<String, dynamic>>> denunceDaAccettare;
      Stream<QuerySnapshot<Map<String, dynamic>>> denunce =
          DenunciaController().generaStreamDenunciaByUtente(utente!);

      if (utente.tipo == TipoUtente.UffPolGiud) {
        denunceDaAccettare = DenunciaController()
            .generaStreamDenunciaByStatoAndCap(
                StatoDenuncia.NonInCarico, utente);
      } else {
        denunceDaAccettare = const Stream.empty();
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sezione Denunce',
            style: ThemeText.titoloSezione,
          ),
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
                      "Prese in carico",
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
              child: StreamBuilder(
                  stream: denunce,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Errore nello snapshot.");
                    } else {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const Text("Nessuna Denuncia.");
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());
                        case ConnectionState.active:
                          {
                            List<Denuncia>? listaDenunce = snapshot.data?.docs
                                .map((e) =>
                                    DenunciaController().jsonToDenuncia(e))
                                .toList();
                            if (listaDenunce == null) {
                              return const Text("Non ci sono denunce.");
                            } else {
                              return TabBarView(
                                children: [
                                  //1st tab
                                  RefreshIndicator(
                                    key: _refreshIndicatorKey1,
                                    onRefresh: _pullRefresh,
                                    child: Consumer<SuperUtente?>(
                                      builder: (context, utente, _) {
                                        if (utente?.tipo == TipoUtente.Utente) {
                                          return VisualizzaDenunceWidget(
                                              denunce: listaDenunce
                                                  .where((event) =>
                                                      event.statoDenuncia ==
                                                      StatoDenuncia.NonInCarico)
                                                  .toList());
                                        } else {
                                          //generazione della lista di denunce da attettare nel caso si un uff
                                          return StreamBuilder(
                                              stream: denunceDaAccettare,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasError) {
                                                  return const Text(
                                                      "Errore nello snapshot.");
                                                } else {
                                                  switch (snapshot
                                                      .connectionState) {
                                                    case ConnectionState.none:
                                                      return const Text(
                                                          "Nessuna Denuncia.");
                                                    case ConnectionState
                                                        .waiting:
                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    case ConnectionState.active:
                                                      List<Denuncia>?
                                                          listaDenunce =
                                                          snapshot.data?.docs
                                                              .map((e) =>
                                                                  DenunciaController()
                                                                      .jsonToDenuncia(
                                                                          e))
                                                              .toList();
                                                      return VisualizzaDenunceWidget(
                                                          denunce:
                                                              listaDenunce!);
                                                    case ConnectionState.done:
                                                      List<Denuncia>?
                                                          listaDenunce =
                                                          snapshot.data?.docs
                                                              .map((e) =>
                                                                  DenunciaController()
                                                                      .jsonToDenuncia(
                                                                          e))
                                                              .toList();
                                                      return VisualizzaDenunceWidget(
                                                          denunce:
                                                              listaDenunce!);
                                                  }
                                                }
                                              });
                                        }
                                      },
                                    ),
                                  ),
                                  //2nd tab
                                  RefreshIndicator(
                                    key: _refreshIndicatorKey2,
                                    onRefresh: _pullRefresh,
                                    child: VisualizzaDenunceWidget(
                                        denunce: listaDenunce
                                            .where((event) =>
                                                event.statoDenuncia ==
                                                StatoDenuncia.PresaInCarico)
                                            .toList()),
                                  ),
                                  //3rd tab
                                  RefreshIndicator(
                                    key: _refreshIndicatorKey3,
                                    onRefresh: _pullRefresh,
                                    child: VisualizzaDenunceWidget(
                                        denunce: listaDenunce
                                            .where((event) =>
                                                event.statoDenuncia ==
                                                StatoDenuncia.Chiusa)
                                            .toList()),
                                  )
                                ],
                              );
                            }
                          }
                        case ConnectionState.done:
                          {
                            List<Denuncia>? listaDenunce = snapshot.data?.docs
                                .map((e) => Denuncia.fromJson(e.data()))
                                .toList();
                            if (listaDenunce == null) {
                              return const Text("Non ci sono denunce.");
                            } else {
                              return TabBarView(
                                children: [
                                  //1st tab
                                  Consumer<SuperUtente?>(
                                    builder: (context, utente, _) {
                                      if (utente?.tipo == TipoUtente.Utente) {
                                        return VisualizzaDenunceWidget(
                                            denunce: listaDenunce
                                                .where((event) =>
                                                    event.statoDenuncia ==
                                                    StatoDenuncia.NonInCarico)
                                                .toList());
                                      } else {
                                        return VisualizzaDenunceWidget(
                                            denunce: listaDenunce
                                                .where((event) =>
                                                    event.statoDenuncia ==
                                                    StatoDenuncia.NonInCarico)
                                                .toList());
                                      }
                                    },
                                  ),
                                  //2nd tab
                                  VisualizzaDenunceWidget(
                                      denunce: listaDenunce
                                          .where((event) =>
                                              event.statoDenuncia ==
                                              StatoDenuncia.PresaInCarico)
                                          .toList()),
                                  //3rd tab
                                  VisualizzaDenunceWidget(
                                      denunce: listaDenunce
                                          .where((event) =>
                                              event.statoDenuncia ==
                                              StatoDenuncia.Chiusa)
                                          .toList())
                                ],
                              );
                            }
                          }
                      }
                    }
                  }),
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
                              InoltroDenuncia(utente: utente!),
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
    } else {
      return Container();
    }
  }
}
