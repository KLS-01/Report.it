import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_it/domain/entity/denuncia_entity.dart';

var db = FirebaseFirestore.instance;

class DenunciaDao {
  static Future<DocumentReference<Object?>> addDenuncia(Denuncia denuncia) {
    Future<DocumentReference<Object?>> id = db
        .collection("Denuncia")
        .add(denuncia.toMap())
      ..then((doc) => log('Data added with success with ID: ${doc.id}'));
    return id;
  }

  static void updateId(String id) async {
    DocumentReference? returnCode;
    try {
      returnCode = FirebaseFirestore.instance.collection('Denuncia').doc(id);
      await returnCode.update({"ID": id});
    } catch (e) {
      log("Error: ");
      return null;
    }
  }
}
