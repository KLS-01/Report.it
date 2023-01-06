import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_it/domain/entity/discussione_entity.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

Future<List<Discussione?>> RetrieveAllForum() async {
  var ref = database.collection("Discussione");

  List<Discussione> lista = List.empty(growable: true);

  var u = await ref.get().then((value) async {
    for (var c in value.docs) {
      Discussione ut = Discussione.fromJson(c.data());

      ut.commenti.addAll(await RetrieveAllCommenti(ut.id!));
      lista.add(ut);
    }

    return lista;
  });

  return u;
}

Future<List<Commento?>> RetrieveAllCommenti(String id) async {
  var ref = database.collection("Discussione/$id/Commento");

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
      print(c.data());
      Discussione? ut = Discussione.fromJson(c.data());
      print(ut.id);

      ut.commenti.addAll(await RetrieveAllCommenti(ut.id!));
      lista.add(ut);
    }

    return lista;
  });

  return u;
}

void AggiungiCommento(Commento commento, String discussione) {
  var ref = database.collection("Discussione/$discussione");
}

void AggiungiDiscussione(Discussione discussione) {
  var ref = database.collection("Discussione");

  ref.add(discussione.toMap()).then((value) => discussione.id = value.id);
}
