import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/data/Models/denuncia_dao.dart';
import 'package:report_it/domain/entity/categoria_denuncia.dart';
import 'package:report_it/domain/entity/stato_denuncia.dart';
import 'package:report_it/domain/entity/super_utente.dart';
import 'package:report_it/domain/entity/tipo_utente.dart';
import 'package:report_it/presentation/pages/dettagli_denuncia_page.dart';
import 'package:report_it/presentation/pages/dettagli_denuncia.dart';

import '../../firebase_options.dart';
import '../../domain/entity/denuncia_entity.dart';
import '../../domain/entity/utente_entity.dart';
import '../../../domain/repository/denuncia_controller.dart';

import 'package:flutter/material.dart';
import '../../../domain/repository/denuncia_controller.dart';
import 'inoltro_denuncia_page.dart';
import '../widget/visualizza_denunce_widget.dart';

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
  Widget build(BuildContext context) {
    SuperUtente? utente= context.watch<SuperUtente?>();

    Future<List<Denuncia>> denunceDaAccettare;
    if(utente?.tipo== TipoUtente.UffPolGiud){
      denunceDaAccettare= DenunciaController().visualizzaDenunceByStato(StatoDenuncia.NonInCarico);
    }else{
      denunceDaAccettare=generaListaVuota();
    }
    denunce= generaListaDenunce(context.watch<SuperUtente?>());
    return MaterialApp(
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
          body:TabBarView(
             children: [
                      //1st tab
                      Consumer<SuperUtente?>(
                        builder: (context, utente,_){
                            if(utente?.tipo==TipoUtente.Utente){
                              return VisualizzaDenunceWidget(denunce: DenunciaController().filtraDenunciaByStato(denunce, StatoDenuncia.NonInCarico));
                            }else{
                              return VisualizzaDenunceWidget(denunce: denunceDaAccettare);
                            }
                        },
                      ),
                      //2nd tab
                      VisualizzaDenunceWidget(denunce: DenunciaController().filtraDenunciaByStato(denunce, StatoDenuncia.PresaInCarico)),
                      //3rd tab
                      VisualizzaDenunceWidget(denunce: DenunciaController().filtraDenunciaByStato(denunce, StatoDenuncia.Chiusa))
                  ],
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

