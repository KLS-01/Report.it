import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_it/domain/entity/entity_GA/operatoreCUP_entity.dart';
import 'package:report_it/domain/entity/entity_GA/spid_entity.dart';
import 'package:report_it/domain/entity/entity_GA/utente_entity.dart';

import '../../domain/entity/entity_GA/uffPolGiud_entity.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

Future<SPID?> RetrieveSPIDByEmail(String email) async {
  var ref = database.collection("SPID").where("Email", isEqualTo: email);
  print(email);

  var u = await ref.get().then(((value) async {
    print(value.docs);
    SPID u = SPID.fromJson(value.docs.first.data());

    return u;
  }));

  return u;
}

// ignore: non_constant_identifier_names
Future<Utente?> RetrieveUtenteByID(String uid) async {
  var ref = database.collection("Utente").doc(uid);

  var u = await ref.get().then(((value) async {
    if (value.data() == null) {
      return null;
    } else {
      Utente u = Utente.fromJson(value.data()!);

      var spid = await RetrieveSPIDByID(uid);

      u.setSpid(spid!);

      return u;
    }
  }));

  return u;
}

// ignore: non_constant_identifier_names
Future<SPID?> RetrieveSPIDByID(String uid) async {
  var ref = database.collection("SPID").doc(uid);

  var u = await ref.get().then(((value) {
    if (value.data() == null) {
      return null;
    } else {
      SPID u = SPID.fromJson(value.data()!);
      return u;
    }
  }));

  return u;
}

// ignore: non_constant_identifier_names
Future<UffPolGiud?> RetrieveUffPolGiudByID(String uid) async {
  var ref = database.collection("UffPolGiud").doc(uid);

  var u = await ref.get().then(((value) {
    if (value.data() == null) {
      return null;
    } else {
      UffPolGiud u = UffPolGiud.fromJson(value.data()!);

      return u;
    }
  }));

  return u;
}

// ignore: non_constant_identifier_names
Future<OperatoreCUP?> RetrieveCUPByID(String uid) async {
  var ref = database.collection("OperatoreCUP").doc(uid);

  var u = await ref.get().then(((value) {
    if (value.data() == null) {
      return null;
    } else {
      OperatoreCUP u = OperatoreCUP.fromJson(value.data()!);

      return u;
    }
  }));
  return u;
}

// ignore: non_constant_identifier_names
Future<List<Utente?>> RetrieveAllUtente() async {
  var ref = database.collection("Utente");

  List<Utente> lista = List.empty(growable: true);

  var u = await ref.get().then((value) async {
    for (var c in value.docs) {
      Utente ut = Utente.fromJson(c.data());

      var spid = await RetrieveSPIDByID(ut.id);
      ut.setSpid(spid!);
      lista.add(ut);
    }

    return lista;
  });

  return u;
}

// ignore: non_constant_identifier_names
Future<List<SPID?>> RetrieveAllSPID() async {
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
Future<List<UffPolGiud?>> RetrieveAllUffPolGiud() async {
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
Future<List<OperatoreCUP?>> RetrieveAllOperatoreCUP() async {
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
