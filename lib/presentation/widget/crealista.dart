import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GF/discussione_entity.dart';
import 'package:report_it/domain/repository/forum_controller.dart';
import 'package:report_it/presentation/widget/commento.dart';
import 'package:report_it/presentation/widget/like.dart';
import 'package:report_it/presentation/widget/styles.dart';
import 'package:report_it/presentation/widget/widgetImmagine.dart';

class crealista extends StatefulWidget {
  const crealista({super.key, required this.list, required this.Callback});

  final Future<List<Discussione?>?> list;
  final Callback;

  @override
  State<crealista> createState() => _crealistaState();
}

class _crealistaState extends State<crealista> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey2 =
      GlobalKey<RefreshIndicatorState>();
  void callback2() {
    setState(() {});
  }

  bool commenti = false;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _pullRefresh,
      child: FutureBuilder(
          future: widget.list,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  return index != (snapshot.data!.length - 1)
                      ? CreaDiscussione(
                          snapshot: snapshot,
                          index: index,
                          context: context,
                          callback: widget.Callback,
                          callback2: callback2,
                        )
                      : Column(
                          children: [
                            CreaDiscussione(
                              snapshot: snapshot,
                              index: index,
                              context: context,
                              callback: widget.Callback,
                              callback2: callback2,
                            ),
                            const SizedBox(
                              height: 70,
                            )
                          ],
                        );
                }),
              );
            }
          }),
    );
  }

  Future<void> _pullRefresh() async {
    ForumService().AggiornaLista();
    setState(() {});
    widget.Callback();
  }
}

class CreaDiscussione extends StatefulWidget {
  const CreaDiscussione(
      {super.key,
      required this.snapshot,
      required this.index,
      required this.context,
      required this.callback,
      required this.callback2});
  final snapshot;
  final index;
  final context;
  final callback;
  final callback2;

  @override
  State<CreaDiscussione> createState() => _CreaDiscussioneState();
}

class _CreaDiscussioneState extends State<CreaDiscussione> {
  User? utente = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    bool flag = widget.snapshot.data![widget.index]!.listaSostegno
        .contains(utente!.uid);
    int numero = widget.snapshot.data![widget.index]!.listaSostegno.length;
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            child: Card(
              elevation: 8,
              color: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                //set border radius more than 50% of height and width to make circle
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.01,
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.account_circle,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${widget.snapshot.data![widget.index]!.nome!} ${widget.snapshot.data![widget.index]!.cognome!}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.grey,
                            height: 20,
                            thickness: 1,
                            indent: 1,
                            endIndent: 1,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                widget.snapshot.data![widget.index]!.titolo,
                                style: ThemeText.titoloForum),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.snapshot.data![widget.index]!.testo,
                          style: ThemeText.corpoForum),
                    ),
                  ),
                  CardImaggine(
                    immagine: widget.snapshot.data![widget.index]!.pathImmagine,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Row(
                          children: [
                            like(
                              discussione: widget.snapshot.data![widget.index]!,
                              callback: widget.callback2,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Commenti(
                          discussione: widget.snapshot.data![widget.index]!,
                          callback: widget.callback2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Consumer<SuperUtente?>(
            builder: ((context, value, child) {
              return value!.id ==
                      widget.snapshot.data![widget.index]!.idCreatore
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.85, 0, 0, 0),
                      child: Material(
                        color: Colors.transparent,
                        child: PopupMenuButton(
                          itemBuilder: (context) {
                            List<PopupMenuEntry<Object>> list = [];
                            list.add(
                              widget.snapshot.data![widget.index]!.stato ==
                                      "Aperta"
                                  ? PopupMenuItem(
                                      onTap: (() {
                                        ForumService().ChiudiDiscussione(widget
                                            .snapshot.data![widget.index]!.id);
                                        ForumService().AggiornaLista();
                                        widget.callback();
                                      }),
                                      child: const Text("Chiudi discussione"),
                                    )
                                  : PopupMenuItem(
                                      onTap: (() {
                                        ForumService().ApriDiscussione(widget
                                            .snapshot.data![widget.index]!.id);
                                        ForumService().AggiornaLista();
                                        widget.callback;
                                      }),
                                      child: const Text("Apri discussione"),
                                    ),
                            );
                            list.add(
                              PopupMenuItem(
                                onTap: (() {
                                  ForumService().EliminaDiscussione(
                                      widget.snapshot.data![widget.index]!.id);
                                  ForumService().AggiornaLista();
                                  widget.callback();
                                }),
                                child: const Text("Elimina discussione"),
                              ),
                            );
                            return list;
                          },
                        ),
                      ),
                    )
                  : Container();
            }),
          ),
        ],
      ),
    );
  }
}
