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
import '../../data/models/AutenticazioneDAO.dart';


Color? containerColor;
List<Color> containerColors = [
  const Color(0xFFFDE1D7),
  const Color(0xFFE4EDF5),
  const Color(0xFFE7EEED),
  const Color(0xFFF4E4CE),
];


class VisualizzaStoricoDenunceUtentePage extends StatefulWidget {
  const VisualizzaStoricoDenunceUtentePage({Key? key}) : super(key: key);

  @override
  State<VisualizzaStoricoDenunceUtentePage> createState() =>
      _VisualizzaStoricoDenunceUtentePageState();
}

class _VisualizzaStoricoDenunceUtentePageState extends State<VisualizzaStoricoDenunceUtentePage> {
  late Future<List<Denuncia>> denunce;

  @override
  void initState() {
    super.initState();
    denunce = generaListaDenunce();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        Text("le tue denunce"),
        Padding(
          padding: const EdgeInsets.all(100.0),
          child: ElevatedButton(
              onPressed: () {},
              child: Text("visualizza")),
        ),
        Expanded(
          child: Consumer<SuperUtente?>(
            builder: (context, utente,child){
              if(utente==null){
                return const Text("Errore non sei loggato");
              }else {
                if (utente.tipo == TipoUtente.Utente) {
                  return FutureBuilder<List<Denuncia>>(
                      future: denunce,
                      builder: (BuildContext context, AsyncSnapshot<List<Denuncia>> snapshot)
                      {
                        var data = snapshot.data;
                        if (data == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else
                        {
                          var datalenght = data.length;
                          if (datalenght == 0) {
                            return const Center(
                              child: Text('Nessuna denuncia trovata'),
                            );
                          }
                          else
                          {
                            return ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  final item = snapshot.data![index];

                                  return ListTile(
                                    title: Text(item.descrizione)
                                  );
                                }
                            );
                          }
                        }
                      }
                  );
                }
                else {
                  return const Text(
                      "Non hai l'autorizzazione per visualizzare la pagina");
                }
              }
            }//builder del consumer
          ) ,
        )
      ]
    );
  }
}



Future<List<Denuncia>> generaListaDenunce() {
  DenunciaController controller = DenunciaController();

  return controller.visualizzaStoricoDenunceByUtente();
}


