

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
import 'presentation/pages/visualizza_denunce_page.dart';



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

    return const MaterialApp(
      title: title,
      home: VisualizzaDenunceUtentePage()
    );
  }
}








