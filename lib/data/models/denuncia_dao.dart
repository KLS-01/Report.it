import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../domain/entity/denuncia_entity.dart';

import 'package:cloud_firestore/cloud_firestore.dart';


FirebaseFirestore db= FirebaseFirestore.instance;

Future<Denuncia?> RetriveDenunciaById(String id) async{
  var ref= db.collection("Denuncia").doc(id);

  await ref.get().then((value){
    Denuncia d= Denuncia.fromJson(value.data()!);
    return d;
  });
}



