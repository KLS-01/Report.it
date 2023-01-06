import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/data/Models/denuncia_dao.dart';
import 'package:report_it/domain/entity/categoria_denuncia.dart';
import 'package:report_it/domain/entity/stato_denuncia.dart';
import 'package:report_it/domain/entity/super_utente.dart';
import 'package:report_it/domain/entity/tipo_utente.dart';
import 'package:report_it/domain/entity/uffPolGiud_entity.dart';

import '../../firebase_options.dart';
import '../../domain/entity/denuncia_entity.dart';
import '../../domain/entity/utente_entity.dart';
import '../../../domain/repository/denuncia_controller.dart';

import 'package:flutter/material.dart';
import '../../../domain/repository/denuncia_controller.dart';
import '../../data/models/AutenticazioneDAO.dart';




class TestProvider extends StatefulWidget {
  const TestProvider({Key? key}) : super(key: key);

  @override
  State<TestProvider> createState() => _TestProviderState();
}

class _TestProviderState extends State<TestProvider> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SuperUtente?>(
      builder:(context, utente,__){
        return Padding(
          padding: const EdgeInsets.all(100),
          child: ElevatedButton(
            onPressed: () async {
              Utente? ut= await RetrieveUtenteByID("MjQfAm3PDdOS3BUFJWkrrGBdHyR2");
              UffPolGiud? uff =await RetrieveUffPolGiudByID("MjQfAm3PDdOS3BUFJWkrrGBdHyR2");
              if(ut==null){
                print("non sei un utente");
              }else if(uff==null){
                print("non sei un uff");
              }else{
                print("sei un op");
              }
            },
            child: Text("Premi stronzo"),
          ),
        );
        if(utente==null){
          return const Text("Errore");
        }else{
          return Text(utente.tipo.name);
        }
      }
    );
  }
}
