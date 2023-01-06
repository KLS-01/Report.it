import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/data/Models/denuncia_dao.dart';
import 'package:report_it/domain/entity/categoria_denuncia.dart';
import 'package:report_it/domain/entity/stato_denuncia.dart';
import 'package:report_it/domain/entity/super_utente.dart';
import 'package:report_it/domain/entity/tipo_utente.dart';

import '../../firebase_options.dart';
import '../../domain/entity/denuncia_entity.dart';
import '../../domain/entity/utente_entity.dart';
import '../../../domain/repository/denuncia_controller.dart';

import 'package:flutter/material.dart';
import '../../../domain/repository/denuncia_controller.dart';
import 'inoltro_denuncia_page.dart';

class VisualizzaStoricoDenunceUtentePage extends StatefulWidget {
  const VisualizzaStoricoDenunceUtentePage({Key? key}) : super(key: key);

  @override
  State<VisualizzaStoricoDenunceUtentePage> createState() =>
      _VisualizzaStoricoDenunceUtentePageState();
}

class _VisualizzaStoricoDenunceUtentePageState
    extends State<VisualizzaStoricoDenunceUtentePage> {
  late Future<List<Denuncia>> denunce;

  @override
  void initState() {
    super.initState();
    denunce = generaListaDenunce();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            bottom: const TabBar(
              labelColor: Color.fromRGBO(219, 29, 69, 1),
              indicatorColor: Color.fromRGBO(219, 29, 69, 1),
              tabs: [
                Tab(
                  child: Text(
                    "In attesa",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Tab(
                  child: Text(
                    "Prese in carico",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Tab(
                  child: Text(
                    "Storico",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              //1st tab

              Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                    child: Consumer<SuperUtente?>(
                      builder: (context, utente,_){
                        if(utente==null){
                          return const Text("non sei loggato");
                        }
                        else{
                          if(utente.tipo!= TipoUtente.Utente){
                            return const Text("Errore non hai i permessi");
                          }
                          else{
                            return FutureBuilder<List<Denuncia>>(
                              future: denunce,
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Denuncia>> snapshot) {
                                var data = snapshot.data;
                                if (data == null) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  var datalenght = data.length;
                                  if (datalenght == 0) {
                                    return const Center(
                                      child: Text('Nessuna denuncia trovata'),
                                    );
                                  } else {
                                    return ListView.builder(
                                      itemCount: snapshot.data?.length,
                                      itemBuilder: (context, index) {
                                        final item = snapshot.data![index];

                                        return Container(
                                          margin: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            // color: Color.fromARGB(255, 228, 228, 228),
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 2.0,
                                                  spreadRadius: 0.0,
                                                  offset: Offset(1.5, 1.5),
                                                )
                                              ]),
                                          child: ListTile(
                                            title: Text(item.descrizione),
                                            subtitle:
                                            Text(item.categoriaDenuncia.toString()),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),

              //2nd tab
              Container(
                child: const Text(
                  'Sorm',
                  style: TextStyle(fontSize: 40),
                  textAlign: TextAlign.center,
                ),
              ),
              //3rd tab
              Container(
                child: const Text(
                  'Mammt',
                  style: TextStyle(fontSize: 40),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InoltroDenuncia(),
                ),
              );
            },
            backgroundColor: const Color.fromRGBO(219, 29, 69, 1),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

Future<List<Denuncia>> generaListaDenunce() {
  DenunciaController controller = DenunciaController();

  return controller.visualizzaStoricoDenunceByUtente();
}
