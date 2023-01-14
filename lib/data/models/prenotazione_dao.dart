import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:report_it/data/models/AutenticazioneDAO.dart';
import 'package:report_it/domain/entity/operatoreCUP_entity.dart';
import 'package:report_it/domain/entity/prenotazione_entity.dart';
import 'package:report_it/domain/entity/super_utente.dart';

var db = FirebaseFirestore.instance;
final String DOCUMENT_NAME = "Prenotazione";

class PrenotazioneDao {
  static Future<DocumentReference<Object?>> addPrenotazione(
      Prenotazione prenotazione) {
    Future<DocumentReference<Object?>> id = db
        .collection(DOCUMENT_NAME)
        .add(prenotazione.toMap())
      ..then((doc) => log('Data added with success with ID: ${doc.id}'));
    return id;
  }

  static void updateId(String id) async {
    DocumentReference? returnCode;
    try {
      returnCode = FirebaseFirestore.instance.collection(DOCUMENT_NAME).doc(id);
      await returnCode.update({"ID": id});
    } catch (e) {
      log("Error: ");
      return null;
    }
  }

  static void updateAttribute(String id, String attribute, var value) async {
    DocumentReference? returnCode;
    try {
      returnCode = FirebaseFirestore.instance.collection(DOCUMENT_NAME).doc(id);
      await returnCode.update({attribute: value});
    } catch (e) {
      log("Error: ");
      return null;
    }
  }

  static Future<String?> uploadImpegnativa(Uint8List asset, String name) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref("Impegnative").child(name);
    UploadTask uploadTask = ref.putData(asset);
    String? url;
    url = await uploadTask.then((res) async {
      var d = await res.ref.getDownloadURL();
      return d;
    });
    print("Caricata impegnativa all'url: $url");
    return url;
  }

  Future<Prenotazione?> retrieveById(String id) async {
    var ref = db.collection(DOCUMENT_NAME).doc(id);

    var d = await ref.get().then(((value) {
      if (value.data() != null) {
        Prenotazione? d = Prenotazione.fromJson(value.data()!);
        return d;
      } else {
        return null;
      }
    }));

    return d;
  }

  Future<List<Prenotazione>> retrieveAll() async {
    var ref = db.collection(DOCUMENT_NAME);
    List<Prenotazione> lista = List.empty(growable: true);
    await ref.get().then(((value) {
      for (var snap in value.docs) {
        Prenotazione prenotazione = Prenotazione.fromJson(snap.data());
        lista.add(prenotazione);
      }

      return lista;
    }));
    return lista;
  }

  Future<List<Prenotazione>> retrieveByUtente(idUtente) async {
    print("data $idUtente");
    var ref =
        db.collection(DOCUMENT_NAME).where("IDUtente", isEqualTo: idUtente);
    List<Prenotazione> lista = List.empty(growable: true);
    await ref.get().then(((value) {
      for (var snap in value.docs) {
        Prenotazione prenotazione = Prenotazione.fromJson(snap.data());
        lista.add(prenotazione);
      }

      return lista;
    }));
    return lista;
  }

  Future<List<Prenotazione>> retrieveByOperatore(idOperatore) async {
    print("data $idOperatore");
    var ref = db
        .collection(DOCUMENT_NAME)
        .where("IDOperatore", isEqualTo: idOperatore);
    List<Prenotazione> lista = List.empty(growable: true);
    await ref.get().then(((value) {
      for (var snap in value.docs) {
        Prenotazione prenotazione = Prenotazione.fromJson(snap.data());
        lista.add(prenotazione);
      }

      return lista;
    }));
    return lista;
  }

  Future<List<Prenotazione>> retrieveAttive() async {
    var ref =
        db.collection(DOCUMENT_NAME).where("DataPrenotazione", isNull: true);
    List<Prenotazione> lista = List.empty(growable: true);
    await ref.get().then(((value) {
      for (var snap in value.docs) {
        Prenotazione prenotazione = Prenotazione.fromJson(snap.data());
        lista.add(prenotazione);
      }

      return lista;
    }));
    //print("Print Data layer: $lista");
    return lista;
  }

  void accettaPrenotazione(
      {required String idPrenotazione,
      required String idOperatore,
      required GeoPoint coordASL,
      required Timestamp dataPrenotazione,
      required String nomeASL}) {
    var ref = db.collection(DOCUMENT_NAME).doc(idPrenotazione);

    ref.update({
      "CoordASL": coordASL,
      "IDOperatore": idOperatore,
      "DataPrenotazione": dataPrenotazione,
      "NomeASL": nomeASL,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> retrieveStreamAttive(
      SuperUtente operatore) {
    Stream<QuerySnapshot<Map<String, dynamic>>> ref = db
        .collection(DOCUMENT_NAME)
        .where("DataPrenotazione", isNull: true)
        .where("CAP", isEqualTo: operatore.cap)
        .snapshots();

    print("ref $ref");
    return ref;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> retrieveStreamByUtente(idUtente) {
    var ref = db
        .collection(DOCUMENT_NAME)
        .where("IDUtente", isEqualTo: idUtente)
        .where("DataPrenotazione")
        .snapshots();

    return ref;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> retrieveStreamByOperatore(
      idOperatore) {
    var ref = db
        .collection(DOCUMENT_NAME)
        .where("IDOperatore", isEqualTo: idOperatore)
        .snapshots();

    return ref;
  }
}
