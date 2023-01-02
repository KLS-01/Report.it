import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_it/domain/entity/denuncia_entity.dart';

var db = FirebaseFirestore.instance;

class DenunciaDao {
  static DocumentReference? addDenuncia(Denuncia denuncia) {
    DocumentReference? id;
    db
        .collection("Denuncia")
        .add(denuncia.toMap())
        .then((DocumentReference doc) => id = doc);
    log('Data added with success with ID: ${id.toString()}');
    return id;
  }
}
