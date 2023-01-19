import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GF/discussione_entity.dart';
import 'package:report_it/domain/repository/forum_controller.dart';
import 'package:report_it/presentation/widget/commento.dart';
import 'package:report_it/presentation/widget/like.dart';
import 'package:report_it/presentation/widget/widgetImmagine.dart';

class crealista extends StatefulWidget {
  const crealista({super.key, required this.list, required this.Callback});

  final Future<List<Discussione?>?> list;
  final Callback;

  @override
  State<crealista> createState() => _crealistaState();
}

class _crealistaState extends State<crealista> {
  User? utente = FirebaseAuth.instance.currentUser;
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
                  bool flag = snapshot.data![index]!.listaSostegno
                      .contains(utente!.uid);
                  int numero = snapshot.data![index]!.listaSostegno.length;
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
                                              "${snapshot.data![index]!.nome!} ${snapshot.data![index]!.cognome!}",
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
                                            snapshot.data![index]!.titolo,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      snapshot.data![index]!.testo,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                CardImaggine(
                                  immagine: snapshot.data![index]!.pathImmagine,
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.height *
                                            0.01,
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
                                            discussione: snapshot.data![index]!,
                                            callback: callback2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Commenti(
                                        discussione: snapshot.data![index]!,
                                        callback: callback2,
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
                                    snapshot.data![index]!.idCreatore
                                ? Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.85,
                                        0,
                                        0,
                                        0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: PopupMenuButton(
                                        itemBuilder: (context) {
                                          List<PopupMenuEntry<Object>> list =
                                              [];
                                          list.add(
                                            snapshot.data![index]!.stato ==
                                                    "Aperta"
                                                ? PopupMenuItem(
                                                    onTap: (() {
                                                      ForumService()
                                                          .ChiudiDiscussione(
                                                              snapshot
                                                                  .data![index]!
                                                                  .id);
                                                      ForumService()
                                                          .AggiornaLista();
                                                      widget.Callback();
                                                    }),
                                                    child: const Text(
                                                        "Chiudi discussione"),
                                                  )
                                                : PopupMenuItem(
                                                    onTap: (() {
                                                      ForumService()
                                                          .ApriDiscussione(
                                                              snapshot
                                                                  .data![index]!
                                                                  .id);
                                                      ForumService()
                                                          .AggiornaLista();
                                                      widget.Callback();
                                                    }),
                                                    child: const Text(
                                                        "Apri discussione"),
                                                  ),
                                          );
                                          list.add(
                                            PopupMenuItem(
                                              onTap: (() {
                                                ForumService()
                                                    .EliminaDiscussione(snapshot
                                                        .data![index]!.id);
                                                ForumService().AggiornaLista();
                                                widget.Callback();
                                              }),
                                              child: const Text(
                                                  "Elimina discussione"),
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
