import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_it/domain/entity/discussione_entity.dart';

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

      ut.commenti.addAll(await RetrieveAllCommenti(ut.id!));
      lista.add(ut);
    }

    return lista;
  });

  return u;
}

void AggiungiCommento(Commento commento, String discussione) {
  var ref = database
      .collection("Discussione")
      .doc(discussione)
      .collection("Commento");

  ref.add(commento.toMap());
}

Future<String> AggiungiDiscussione(Discussione discussione) async {
  var ref = database.collection("Discussione");

  String id = await ref.add(discussione.toMap()).then((value) {
    return value.id;
  });

  return id;
}
