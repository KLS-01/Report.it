import 'package:flutter/material.dart';
import 'package:report_it/domain/entity/discussione_entity.dart';
import 'package:report_it/domain/repository/forum_service.dart';
import 'package:report_it/presentation/pages/form_crea_discussione.dart';

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
                return Text(
                  snapshot.data![index]!.titolo,
                  style: TextStyle(color: Colors.black),
                );
              }),
            );
          }
        });
  }
}
