import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_it/domain/entity/denuncia_entity.dart';
import 'package:report_it/domain/entity/stato_denuncia.dart';

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

  static void updateAttribute(String attribute, var value) async {
    DocumentReference? returnCode;
    try {
      returnCode =
          FirebaseFirestore.instance.collection('Denuncia').doc(attribute);
      await returnCode.update({attribute: value});
    } catch (e) {
      log("Error: ");
      return null;
    }
  }

  Future<Denuncia> retrieveById(String id) async {
    var ref = db.collection("Denuncia").doc(id);

    var d = await ref.get().then(((value) {
      Denuncia? d = Denuncia.fromJson(value.data()!);

      return d;
    }));

    return d;
  }

  Future<List<Denuncia>> retrieveAll() async {
    var ref = db.collection("Denuncia");
    List<Denuncia> lista = List.empty(growable: true);
    print("debug dao 1");
    await ref.get().then(((value) {
      for (var snap in value.docs) {
        Denuncia de = Denuncia.fromJson(snap.data());
        lista.add(de);
      }

      return lista;
    }));
    return lista;
  }

  Future<List<Denuncia>> retrieveByUtente(idUtente) async {
    var ref = db.collection("Denuncia").where("IDUtente", isEqualTo: idUtente);
    List<Denuncia> lista = List.empty(growable: true);
    await ref.get().then(((value) {
      for (var snap in value.docs) {
        Denuncia de = Denuncia.fromJson(snap.data());
        lista.add(de);
      }

      return lista;
    }));

    return lista;
  }

  Future<List<Denuncia>> retrieveByUff(idUff) async {
    var ref = db.collection("Denuncia").where("IDUff", isEqualTo: idUff);
    List<Denuncia> lista = List.empty(growable: true);
    await ref.get().then(((value) {
      for (var snap in value.docs) {
        Denuncia de = Denuncia.fromJson(snap.data());
        lista.add(de);
      }

      return lista;
    }));

    return lista;
  }

  Future<List<Denuncia>> retrieveByStato(StatoDenuncia stato) async {
    var ref = db.collection("Denuncia").where("Stato", isEqualTo: stato);
    List<Denuncia> lista = List.empty(growable: true);
    await ref.get().then(((value) {
      for (var snap in value.docs) {
        Denuncia de = Denuncia.fromJson(snap.data());
        lista.add(de);
      }

      return lista;
    }));

    return lista;
  }

  void accettaDenuncia (String idDenuncia, GeoPoint coordCaserma, String idUff, String nomeCaserma, String nomeUff, String cognomeUff){
    var ref= db.collection("Denuncia").doc(idDenuncia);

    ref.update({
      "CognomeUff":cognomeUff,
      "CoordCaserma": coordCaserma,
      "IDUff": idUff,
      "NomeCaserma": nomeCaserma,
      "NomeUff": nomeUff
    });
  }
}
