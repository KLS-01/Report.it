import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_it/domain/entity/denuncia_entity.dart';

var db = FirebaseFirestore.instance;

class DenunciaDao {
  static Future<DocumentReference> addDenuncia(Denuncia denuncia) {
    Future<DocumentReference> id = db
        .collection("Denuncia")
        .add(denuncia.toMap())
      ..then((doc) => log('Data added with success with ID: ${doc.id}'));
    return id;
  }

  static void updateId(DocumentReference id) async {
    await id.update({"ID": id});
  }
}
