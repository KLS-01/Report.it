import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_it/domain/entity/entity_GF/discussione_entity.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

Future<List<Discussione?>> RetrieveAllForum() async {
  var ref = database.collection("Discussione");

  List<Discussione> lista = List.empty(growable: true);

  var u = await ref.get().then((value) async {
    for (var c in value.docs) {
      Discussione ut = Discussione.fromJson(c.data());
      ut.setID(c.id);

      ut.commenti.addAll(await RetrieveAllCommenti(ut.id!));
      lista.add(ut);
    }

    return lista;
  });

  return u;
}

Future<List<Commento?>> RetrieveAllCommenti(String id) async {
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

Future<List<Discussione?>> RetrieveAllForumUtente(String id) async {
  var ref =
      database.collection("Discussione").where("IDCreatore", isEqualTo: id);

  List<Discussione?> lista = List.empty(growable: true);

  var u = await ref.get().then((value) async {
    for (var c in value.docs) {
      Discussione? ut = Discussione.fromJson(c.data());
      ut.id = c.id;

      ut.commenti.addAll(await RetrieveAllCommenti(ut.id!));
      lista.add(ut);
    }

    return lista;
  });

  return u;
}

Future<String> AggiungiCommento(Commento commento, String discussione) async {
  var ref = database
      .collection("Discussione")
      .doc(discussione)
      .collection("Commento");

  String id = await ref.add(commento.toMap()).then((value) {
    return value.id;
  });

  return id;
}

Future<String> AggiungiDiscussione(Discussione discussione) async {
  var ref = database.collection("Discussione");

  String id = await ref.add(discussione.toMap()).then((value) {
    return value.id;
  });

  return id;
}

void CambiaStato(Discussione discussione, String stato) {
  var ref = database.collection("Discussione").doc(discussione.id);

  discussione.stato = stato;

  ref.update(discussione.toMap());
}

void cancellaDenuncia(Discussione discussione) {
  var ref = database.collection("Discussione").doc(discussione.id);

  ref.delete();
}

void cancellaCommento(Commento commento, String idDiscussione) {
  var ref = database
      .collection("Discussione")
      .doc(idDiscussione)
      .collection("Commento")
      .doc(commento.id);

  ref.delete();
}

int supportaDiscussione(Discussione discussione) {
  var ref = database.collection("Discussione").doc(discussione.id);

  discussione.punteggio += 1;

  ref.update(discussione.toMap());

  return discussione.punteggio;
}

int supportaCommento(Commento commento, Discussione discussione) {
  var ref = database
      .collection("Discussione")
      .doc(discussione.id)
      .collection("Commento")
      .doc(commento.id);

  commento.punteggio += 1;

  ref.update(commento.toMap());

  return commento.punteggio;
}
