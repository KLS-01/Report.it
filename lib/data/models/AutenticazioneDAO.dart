import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:report_it/domain/entity/operatoreCUP.dart';
import 'package:report_it/domain/entity/spid_entity.dart';
import 'package:report_it/domain/entity/uffPolGiud_entity.dart';
import 'package:report_it/domain/entity/utente_entity.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

// ignore: non_constant_identifier_names
Future<Utente> RetrieveUtenteByID(String uid) {
  DatabaseReference ref = database.ref("/Utente/$uid");

  var u = ref.get().then(((value) async {
    Utente u = Utente.fromJson(jsonDecode(jsonEncode(value.value)));

    var spid = await RetrieveSPIDByID(uid);

    u.setSpid(spid);

    return u;
  }));

  return u;
}

// ignore: non_constant_identifier_names
Future<SPID> RetrieveSPIDByID(String uid) async {
  DatabaseReference ref = database.ref("/Spid/$uid");

  var u = await ref.get().then(((value) {
    SPID u = SPID.fromJson(jsonDecode(jsonEncode(value.value)));

    return u;
  }));

  return u;
}

// ignore: non_constant_identifier_names
Future<UffPolGiud> RetrieveUffPolGiudByID(String uid) async {
  DatabaseReference ref = database.ref("/UffPolGiud/$uid");

  var u = await ref.get().then(((value) {
    UffPolGiud u = UffPolGiud.fromJson(jsonDecode(jsonEncode(value.value)));

    return u;
  }));

  return u;
}

// ignore: non_constant_identifier_names
Future<OperatoreCUP> RetrieveCUPByID(String uid) async {
  DatabaseReference ref = database.ref("/OperatoreCUP/$uid");

  var u = await ref.get().then(((value) {
    OperatoreCUP u = OperatoreCUP.fromJson(jsonDecode(jsonEncode(value.value)));

    return u;
  }));

  return u;
}

// ignore: non_constant_identifier_names
Future<List<Utente>> RetrieveAllUtente() async {
  DatabaseReference ref = database.ref("/Utente");

  List<Utente> lista = List.empty(growable: true);

  var u = await ref.get().then((value) async {
    for (Map<String, dynamic> c in jsonDecode(jsonEncode(value.value)).values) {
      Utente ut = Utente.fromJson(c);

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
  DatabaseReference ref = database.ref("/Spid");

  List<SPID> lista = List.empty(growable: true);

  var u = await ref.get().then((value) async {
    for (var c in jsonDecode(jsonEncode(value.value)).values) {
      SPID ut = SPID.fromJson(c);
      lista.add(ut);
    }

    return lista;
  });

  return u;
}

// ignore: non_constant_identifier_names
Future<List<UffPolGiud>> RetrieveAllUffPolGiud() async {
  DatabaseReference ref = database.ref("/UffPolGiud");

  List<UffPolGiud> lista = List.empty(growable: true);

  var u = await ref.get().then((value) async {
    for (Map<String, dynamic> c in jsonDecode(jsonEncode(value.value)).values) {
      UffPolGiud ut = UffPolGiud.fromJson(c);
      lista.add(ut);
    }

    return lista;
  });

  return u;
}

// ignore: non_constant_identifier_names
Future<List<OperatoreCUP>> RetrieveAllOperatoreCUP() async {
  DatabaseReference ref = database.ref("/OperatoreCUP");

  List<OperatoreCUP> lista = List.empty(growable: true);

  var u = await ref.get().then((value) async {
    for (Map<String, dynamic> c in jsonDecode(jsonEncode(value.value)).values) {
      OperatoreCUP ut = OperatoreCUP.fromJson(c);
      lista.add(ut);
    }

    return lista;
  });

  return u;
}
