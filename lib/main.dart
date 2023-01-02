

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:report_it/data/Models/denuncia_dao.dart';
import 'package:report_it/domain/entity/categoria_denuncia.dart';
import 'package:report_it/domain/entity/stato_denuncia.dart';

import 'data/firebase_options.dart';
import 'domain/entity/denuncia_entity.dart';
import 'domain/entity/utente_entity.dart';

import 'package:flutter/material.dart';



void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  DenunciaDao dao= new DenunciaDao();
  List<Denuncia> denunce=await dao.retrieveAll();

  runApp(
    MyApp(
      denunce: denunce
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<Denuncia> denunce;

  const MyApp({super.key, required this.denunce});

  @override
  Widget build(BuildContext context) {
    const title = 'Denunce';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body:
          Container(
              child:ListView.builder(
                       // Let the ListView know how many items it needs to build.
                       itemCount: denunce.length,
                       // Provide a builder function. This is where the magic happens.
                       // Convert each item into a widget based on the type of item it is.
                       itemBuilder: (context, index) {
                         final item = denunce[index];

                         return ListTile(
                           title: Text(item.descrizione),
                           subtitle:ElevatedButton(onPressed: createRecord, child: Text("aggiungi")),
                         );
                       },
                     ),
          ),
      )
    );
  }
}




  void stampaDenunce() async{
    DenunciaDao dao= new DenunciaDao();
    print("stampo tutte le denunce");
    List<Denuncia> lista=(await dao.retrieveAll()) as List<Denuncia>;
    print("stampa 2");
    for(var d in lista){
      print(d);
    }
  }


void createRecord() {

  Timestamp scadenzaTS=Timestamp.fromDate(DateTime.now());
  Timestamp dataDenuncia= Timestamp.fromDate(DateTime.now());
  GeoPoint coord = const GeoPoint(3.4, 4.5);
  Denuncia d = Denuncia(
      id: null,
      idUtente: "dVd0S4ptsafnEqPJq938mjEmH3s2",
      nomeDenunciante: "Tizio",
      cognomeDenunciante: "Caio",
      indirizzoDenunciante: "Via Roma 23",
      capDenunciante: "543534",
      provinciaDenunciante: "PD",
      cellulareDenunciante: "548894231658",
      emailDenunciante: "tizio@email.it",
      tipoDocDenunciante: "Carta d'identità",
      numeroDocDenunciante: "420420420420",
      scadenzaDocDenunciante: scadenzaTS,
      dataDenuncia: dataDenuncia,
      categoriaDenuncia: CategoriaDenuncia.OrigineNazionale,
      nomeVittima: "Tizio",
      cognomeVittima: "Caio",
      denunciato: "Nicola Frvgieri",
      alreadyFiled: false,
      consenso: true,
      descrizione: "Denuncia per discriminazione ecceccc",
      statoDenuncia: StatoDenuncia.PresaInCarico,
      nomeCaserma: "Caserma",
      coordCaserma: coord,
      nomeUff: "Adol",
      cognomeUff: "Fitler",
      idUff: " 1PZNxmcGrWVN2ezktgyKFVRWdBS2"
  );

  DenunciaDao.addDenuncia(d).then((DocumentReference<Object?> id) {
    d.setId = id.id;
    DenunciaDao.updateId(d.getId);
  });
}


