import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:report_it/application/entity/entity_GA/super_utente.dart';
import 'package:report_it/application/entity/entity_GPSP/adapter_prenotazione.dart';
import 'package:report_it/application/entity/entity_GPSP/prenotazione_entity.dart';

var db = FirebaseFirestore.instance;
final String DOCUMENT_NAME = "Prenotazione";

class PrenotazioneDao {
  Future<String> addPrenotazione(Prenotazione prenotazione) {
    Future<String> id = db
        .collection(DOCUMENT_NAME)
        .add(AdapterPrenotazione().toMap(prenotazione))
        .then((doc) => doc.id);
    return id;
  }

  void updateId(String id) async {
    DocumentReference? returnCode;
    try {
      returnCode = FirebaseFirestore.instance.collection(DOCUMENT_NAME).doc(id);
      await returnCode.update({"ID": id});
    } catch (e) {
      log("Error: ");
      return null;
    }
  }

  void updateAttribute(String id, String attribute, var value) async {
    DocumentReference? returnCode;
    try {
      returnCode = FirebaseFirestore.instance.collection(DOCUMENT_NAME).doc(id);
      await returnCode.update({attribute: value});
    } catch (e) {
      log("Error: ");
      return null;
    }
  }

  Future<String?> uploadImpegnativa(Uint8List asset, String name) async {
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
        Prenotazione? d = AdapterPrenotazione().fromJson(value.data()!);
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
        Prenotazione prenotazione = AdapterPrenotazione().fromJson(snap.data());
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
        Prenotazione prenotazione = AdapterPrenotazione().fromJson(snap.data());
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
        Prenotazione prenotazione = AdapterPrenotazione().fromJson(snap.data());
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
        Prenotazione prenotazione = AdapterPrenotazione().fromJson(snap.data());
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
      required String nomeASL,
      required String psicologo}) {
    var ref = db.collection(DOCUMENT_NAME).doc(idPrenotazione);

    ref.update({
      "CoordASL": coordASL,
      "IDOperatore": idOperatore,
      "DataPrenotazione": dataPrenotazione,
      "NomeASL": nomeASL,
      "Psicologo": psicologo
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> retrieveStreamAttive(
      SuperUtente operatore) {
    Stream<QuerySnapshot<Map<String, dynamic>>> ref = db
        .collection(DOCUMENT_NAME)
        .where("CAP", isEqualTo: operatore.cap)
        .snapshots();
    print(operatore.cap);
    print("ref $ref");
    return ref;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> retrieveStreamByUtente(idUtente) {
    var ref = db
        .collection(DOCUMENT_NAME)
        .where("IDUtente", isEqualTo: idUtente)
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
