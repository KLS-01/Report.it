import 'package:flutter/material.dart';
import 'package:report_it/domain/entity/discussione_entity.dart';
import 'package:report_it/domain/repository/forum_service.dart';
import 'package:report_it/presentation/pages/form_crea_discussione.dart';
import 'package:app_popup_menu/app_popup_menu.dart';
import 'package:report_it/presentation/widget/theme.dart';

class ForumHome extends StatefulWidget {
  const ForumHome({super.key});

  @override
  State<ForumHome> createState() => _ForumHomeState();
}

class _ForumHomeState extends State<ForumHome> {
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
            crealista(list: ForumService.PrendiTutte()),
            crealista(list: ForumService().Prendiutente())
          ]),
          floatingActionButton: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => ForumForm(),
                  transitionDuration: Duration(seconds: 0),
                  transitionsBuilder: (_, a, __, c) =>
                      FadeTransition(opacity: a, child: c),
                ),
              ).then((value) {
                ForumService().AggiornaLista();
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

class crealista extends StatelessWidget {
  const crealista({super.key, required this.list});

  final Future<List<Discussione?>?> list;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: list,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 40),
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.20,
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
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: Text(
                                  snapshot.data![index]!.titolo,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    snapshot.data![index]!.testo,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.85, 0, 0, 0),
                        child: Material(
                            color: Colors.transparent,
                            child: PopupMenuButton(
                              itemBuilder: (context) {
                                List<PopupMenuEntry<Object>> list = [];
                                list.add(
                                  PopupMenuItem(
                                    child: Text("Chiudi discussione"),
                                    onTap: (() {
                                      ForumService().ChiudiDiscussione(
                                          snapshot.data![index]!.id);
                                    }),
                                  ),
                                );
                                list.add(
                                  PopupMenuItem(
                                    child: Text("Elimina discussione"),
                                    onTap: (() {
                                      ForumService().EliminaDiscussione(
                                          snapshot.data![index]!.id);
                                    }),
                                  ),
                                );
                                return list;
                              },
                            )),
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
