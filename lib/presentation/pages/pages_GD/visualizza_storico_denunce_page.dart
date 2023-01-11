import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/data/Models/denuncia_dao.dart';
import 'package:report_it/domain/entity/entity_GD/categoria_denuncia.dart';
import 'package:report_it/domain/entity/entity_GD/stato_denuncia.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/presentation/pages/pages_GD/dettagli_denuncia_page.dart';
import 'package:report_it/presentation/pages/pages_GD/dettagli_denuncia.dart';

import '../../../firebase_options.dart';
import '../../../domain/entity/entity_GD/denuncia_entity.dart';
import '../../../domain/entity/entity_GA/utente_entity.dart';
import '../../../../domain/repository/denuncia_controller.dart';

import 'package:flutter/material.dart';
import '../../../../domain/repository/denuncia_controller.dart';
import '../../widget/theme.dart';
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



  @override
  Widget build(BuildContext context) {
    SuperUtente? utente= context.watch<SuperUtente?>();

    Stream<QuerySnapshot<Map<String,dynamic>>> denunce=DenunciaController().generaStreaUtenteByUtente(utente!);
    
    return MaterialApp(
      theme: AppTheme().build(),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
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
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: Text(
                    "Prese in carico",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: Text(
                    "Storico",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body:StreamBuilder(
            stream: denunce,
            builder: (context, snapshot) {
              if(snapshot.hasError){
                return Text("Errore nello snapshot");
              }else{
                switch(snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text("Nessuna Denuncia");
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                    break;
                  case ConnectionState.active:{
                    List<Denuncia>? listaDenunce= snapshot.data?.docs.map((e) => Denuncia.fromJson(e.data())).toList();

                    if(listaDenunce==null){
                      return Text("non ci sono denunce");
                    }else{
                      return TabBarView(
                        children: [
                          //1st tab
                          Consumer<SuperUtente?>(
                            builder: (context, utente,_){
                              if(utente?.tipo==TipoUtente.Utente){
                                return VisualizzaDenunceWidget(denunce: listaDenunce.where((event) => event.statoDenuncia==StatoDenuncia.NonInCarico).toList());
                              }else{
                                return VisualizzaDenunceWidget(denunce: listaDenunce.where((event) => event.statoDenuncia==StatoDenuncia.NonInCarico).toList());
                              }
                            },
                          ),
                          //2nd tab
                          VisualizzaDenunceWidget(denunce:listaDenunce.where((event) => event.statoDenuncia==StatoDenuncia.PresaInCarico).toList()),
                          //3rd tab
                          VisualizzaDenunceWidget(denunce:listaDenunce.where((event) => event.statoDenuncia==StatoDenuncia.Chiusa).toList() )
                        ],
                      );
                    }
                  }
                  case ConnectionState.done:{
                    List<Denuncia>? listaDenunce= snapshot.data?.docs.map((e) => Denuncia.fromJson(e.data())).toList();
                    if(listaDenunce==null){
                      return Text("non ci sono denunce");
                    }else{
                      return TabBarView(
                        children: [
                          //1st tab
                          Consumer<SuperUtente?>(
                            builder: (context, utente,_){
                              if(utente?.tipo==TipoUtente.Utente){
                                return VisualizzaDenunceWidget(denunce: listaDenunce.where((event) => event.statoDenuncia==StatoDenuncia.NonInCarico).toList());
                              }else{
                                return VisualizzaDenunceWidget(denunce: listaDenunce.where((event) => event.statoDenuncia==StatoDenuncia.NonInCarico).toList());
                              }
                            },
                          ),
                          //2nd tab
                          VisualizzaDenunceWidget(denunce:listaDenunce.where((event) => event.statoDenuncia==StatoDenuncia.PresaInCarico).toList()),
                          //3rd tab
                          VisualizzaDenunceWidget(denunce:listaDenunce.where((event) => event.statoDenuncia==StatoDenuncia.Chiusa).toList() )
                        ],
                      );
                    }
                  }
                }
              }

            }
          ),
          floatingActionButton: Consumer<SuperUtente?>(
            builder: (context,utente,_){
              if(utente?.tipo==TipoUtente.Utente){
                return FloatingActionButton(
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
                );
              }else{
                return Visibility(
                  visible: false,
                  child: FloatingActionButton(
                    onPressed: () {}
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<List<Denuncia>> generaListaDenunce(SuperUtente? utente) {
  DenunciaController controller = DenunciaController();
  return controller.visualizzaStoricoDenunceByUtente(utente);

}

Future<List<Denuncia>> generaListaVuota()async{
  List<Denuncia> lista= List.empty();
  Future.delayed(Duration.zero);
  return lista;
}

