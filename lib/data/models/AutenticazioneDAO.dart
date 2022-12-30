import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_it/domain/entity/operatoreCUP.dart';
import 'package:report_it/domain/entity/spid_entity.dart';
import 'package:report_it/domain/entity/uffPolGiud_entity.dart';
import 'package:report_it/domain/entity/utente_entity.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

// ignore: non_constant_identifier_names
Future<Utente> RetrieveUtenteByID(String uid) async {
  var ref = database.collection("Utente").doc(uid);

  var u = await ref.get().then(((value) async {
    Utente u = Utente.fromJson(value.data()!);

    var spid = await RetrieveSPIDByID(uid);

    u.setSpid(spid);

    return u;
  }));

  return u;
}

// ignore: non_constant_identifier_names
Future<SPID> RetrieveSPIDByID(String uid) async {
  var ref = database.collection("SPID").doc(uid);

  var u = await ref.get().then(((value) {
    SPID u = SPID.fromJson(value.data()!);

    return u;
  }));

  return u;
}

// ignore: non_constant_identifier_names
Future<UffPolGiud> RetrieveUffPolGiudByID(String uid) async {
  var ref = database.collection("UffPolGiud").doc(uid);

  var u = await ref.get().then(((value) {
    UffPolGiud u = UffPolGiud.fromJson(value.data()!);

    return u;
  }));

  return u;
}

// ignore: non_constant_identifier_names
Future<OperatoreCUP> RetrieveCUPByID(String uid) async {
  var ref = database.collection("OperatoreCUP").doc(uid);

  var u = await ref.get().then(((value) {
    OperatoreCUP u = OperatoreCUP.fromJson(value.data()!);

    return u;
  }));

  return u;
}

// ignore: non_constant_identifier_names
Future<List<Utente>> RetrieveAllUtente() async {
  var ref = database.collection("Utente");

  List<Utente> lista = List.empty(growable: true);

  var u = await ref.get().then((value) async {
    for (var c in value.docs) {
      Utente ut = Utente.fromJson(c.data());

      var spid = await RetrieveSPIDByID(ut.id);
      ut.setSpid(spid);
      lista.add(ut);
    }

    return lista;
  });

  return u;
}

// ignore: non_constant_identifier_names
Future<List<SPID>> RetrieveAllSPID() async {
  var ref = database.collection("SPID");

  List<SPID> lista = List.empty(growable: true);

  var u = await ref.get().then((value) async {
    for (var c in value.docs) {
      SPID ut = SPID.fromJson(c.data());
      lista.add(ut);
    }

    return lista;
  });

  return u;
}

// ignore: non_constant_identifier_names
Future<List<UffPolGiud>> RetrieveAllUffPolGiud() async {
  var ref = database.collection("UffPolGiud");

  List<UffPolGiud> lista = List.empty(growable: true);

  var u = await ref.get().then((value) async {
    for (var c in value.docs) {
      UffPolGiud ut = UffPolGiud.fromJson(c.data());
      lista.add(ut);
    }

    return lista;
  });

  return u;
}

// ignore: non_constant_identifier_names
Future<List<OperatoreCUP>> RetrieveAllOperatoreCUP() async {
  var ref = database.collection("OperatoreCUP");

  List<OperatoreCUP> lista = List.empty(growable: true);

  var u = await ref.get().then((value) async {
    for (var c in value.docs) {
      OperatoreCUP ut = OperatoreCUP.fromJson(c.data());
      lista.add(ut);
    }

    return lista;
  });

  return u;
}
