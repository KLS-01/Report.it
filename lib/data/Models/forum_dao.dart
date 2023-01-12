import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:report_it/domain/entity/discussione_entity.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

class ForumDao {
  static Future<List<Discussione?>> RetrieveAllForum() async {
    var ref = database.collection("Discussione");

    List<Discussione> lista = List.empty(growable: true);

    var u = await ref.get().then((value) async {
      for (var c in value.docs) {
        Discussione ut = Discussione.fromJson(c.data());
        ut.setID(c.id);

        if (ut.pathImmagine != null &&
            (ut.pathImmagine!.startsWith("http") ||
                ut.pathImmagine!.startsWith("gs://"))) {
          final gsReference =
              FirebaseStorage.instance.refFromURL(ut.pathImmagine!);
          await gsReference
              .getDownloadURL()
              .then((value) => ut.setpathImmagine(value));
        }

        ut.commenti.addAll(await RetrieveAllCommenti(ut.id!));
        lista.add(ut);
      }

      return lista;
    });

    return u;
  }

  static Future<List<Commento?>> RetrieveAllCommenti(String id) async {
    var ref = database.collection("Discussione").doc(id).collection("Commento");

    List<Commento> lista = List.empty(growable: true);

    var u = await ref.get().then((value) async {
      for (var c in value.docs) {
        Commento ut = Commento.fromJson(c.data());

        ut.id = c.id;

        lista.add(ut);
      }

      return lista;
    });

    return u;
  }

  static Future<List<Discussione?>> RetrieveAllForumUtente(String id) async {
    var ref =
        database.collection("Discussione").where("IDCreatore", isEqualTo: id);

    List<Discussione?> lista = List.empty(growable: true);

    var u = await ref.get().then((value) async {
      for (var c in value.docs) {
        Discussione? ut = Discussione.fromJson(c.data());
        ut.id = c.id;
        if (!ut.pathImmagine!.startsWith("http") ||
            !ut.pathImmagine!.startsWith("gs://")) {
          final gsReference =
              FirebaseStorage.instance.refFromURL(ut.pathImmagine!);
          await gsReference
              .getDownloadURL()
              .then((value) => ut.setpathImmagine(value));
        }

        ut.commenti.addAll(await RetrieveAllCommenti(ut.id!));
        lista.add(ut);
      }

      return lista;
    });

    return u;
  }

  static Future<String> AggiungiCommento(
      Commento commento, String discussione) async {
    var ref = database
        .collection("Discussione")
        .doc(discussione)
        .collection("Commento");

    String id = await ref.add(commento.toMap()).then((value) {
      return value.id;
    });

    return id;
  }

  static Future<String> AggiungiDiscussione(Discussione discussione) async {
    var ref = database.collection("Discussione");

    String id = await ref.add(discussione.toMap()).then((value) {
      return value.id;
    });

    return id;
  }

  static void CambiaStato(String? discussione, String stato) {
    var ref = database.collection("Discussione").doc(discussione);

    ref.update({"Stato": stato});
  }

  static void cancellaDiscussione(String discussione) {
    var ref = database.collection("Discussione").doc(discussione);

    ref.delete();
  }

  static void cancellaCommento(Commento commento, String idDiscussione) {
    var ref = database
        .collection("Discussione")
        .doc(idDiscussione)
        .collection("Commento")
        .doc(commento.id);

    ref.delete();
  }

  static void modificaPunteggio(String id, int valore) {
    var ref = database.collection("Discussione").doc(id);

    ref.update({"Punteggio": FieldValue.increment(valore)});
  }

  static int supportaCommento(Commento commento, Discussione discussione) {
    var ref = database
        .collection("Discussione")
        .doc(discussione.id)
        .collection("Commento")
        .doc(commento.id);

    commento.punteggio += 1;

    ref.update(commento.toMap());

    return commento.punteggio;
  }

  Future<String> caricaImmagne(FilePickerResult file) async {
    final storageRef = FirebaseStorage.instance.ref();

    var c = storageRef.child("Immagini").child(file.names.first!);

    var u = c.putData(file.files.first.bytes!);

    String path = await u.then((p0) {
      return p0.ref.getDownloadURL();
    });

    return path;
  }
}
