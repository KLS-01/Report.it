import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/data/Models/forum_dao.dart';
import 'package:report_it/domain/entity/discussione_entity.dart';
import 'package:report_it/domain/entity/super_utente.dart';
import 'package:report_it/domain/repository/forum_service.dart';
import 'package:report_it/presentation/pages/form_crea_discussione.dart';
import 'package:report_it/presentation/widget/widgetImmagine.dart';

class ForumHome extends StatefulWidget {
  const ForumHome({super.key});

  @override
  State<ForumHome> createState() => _ForumHomeState();
}

class _ForumHomeState extends State<ForumHome> {
  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(255, 254, 248, 1),
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Theme.of(context).backgroundColor,
            bottom: const TabBar(
              labelColor: Color.fromRGBO(219, 29, 69, 1),
              indicatorColor: Color.fromRGBO(219, 29, 69, 1),
              tabs: [
                Tab(
                  child: Text("Tutte le discussioni"),
                ),
                Tab(
                  child: Text("Le tue discussioni"),
                )
              ],
            ),
          ),
          body: TabBarView(children: [
            crealista(
              list: ForumService.PrendiTutte(),
              Callback: callback,
            ),
            crealista(
              list: ForumService().Prendiutente(),
              Callback: callback,
            )
          ]),
          floatingActionButton: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  //pisnelo
                  pageBuilder: (_, __, ___) => const ForumForm(),
                  transitionDuration: const Duration(seconds: 0),
                  transitionsBuilder: (_, a, __, c) =>
                      FadeTransition(opacity: a, child: c),
                ),
              ).then((value) {
                ForumService().AggiornaLista();
                setState(() {});
              });
              //
            },
            backgroundColor: const Color.fromRGBO(219, 29, 69, 1),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class crealista extends StatefulWidget {
  const crealista({super.key, required this.list, required this.Callback});

  final Future<List<Discussione?>?> list;
  final Callback;

  @override
  State<crealista> createState() => _crealistaState();
}

class _crealistaState extends State<crealista> {
  void callback2() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.list,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Container(
                        child: Card(
                          elevation: 5,
                          color: Colors.grey.shade200,
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
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
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
                                            snapshot.data![index]!.idCreatore,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          snapshot.data![index]!.titolo,
                                          style: const TextStyle(
                                            color: Colors.black,
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
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.01,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20))),
                                child: Row(
                                  children: [
                                    like(
                                      discussione: snapshot.data![index]!.id,
                                      numero: snapshot.data![index]!.punteggio,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Consumer<SuperUtente?>(
                        builder: ((context, value, child) {
                          return value!.id == snapshot.data![index]!.idCreatore
                              ? Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.85,
                                      0,
                                      0,
                                      0),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: PopupMenuButton(
                                      itemBuilder: (context) {
                                        List<PopupMenuEntry<Object>> list = [];
                                        list.add(
                                          PopupMenuItem(
                                            onTap: (() {
                                              ForumService().ChiudiDiscussione(
                                                  snapshot.data![index]!.id);
                                              widget.Callback();
                                            }),
                                            child: const Text(
                                                "Chiudi discussione"),
                                          ),
                                        );
                                        list.add(
                                          PopupMenuItem(
                                            onTap: (() {
                                              ForumService().EliminaDiscussione(
                                                  snapshot.data![index]!.id);
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
        });
  }
}

class like extends StatefulWidget {
  const like({super.key, required this.discussione, required this.numero});
  final discussione;
  final numero;

  @override
  State<like> createState() => _likeState();
}

class _likeState extends State<like> {
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.numero.toString()),
        Material(
          color: Colors.transparent,
          child: flag == false
              ? InkWell(
                  onTap: () {
                    flag = true;
                    ForumService().sostieniDiscusione(widget.discussione);

                    setState(() {});
                  },
                  child: const Icon(
                    Icons.arrow_upward,
                    size: 30,
                  ),
                )
              : InkWell(
                  onTap: () {
                    flag = false;
                    ForumService().desostieniDiscusione(widget.discussione);

                    print("ciao");
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.arrow_downward,
                    size: 30,
                  ),
                ),
        ),
      ],
    );
  }
}
