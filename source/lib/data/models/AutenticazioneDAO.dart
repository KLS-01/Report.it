import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_it/application/entity/entity_GA/adapter_operatoreCUP.dart';
import 'package:report_it/application/entity/entity_GA/adapter_spid.dart';
import 'package:report_it/application/entity/entity_GA/adapter_uffpolgiud.dart';
import 'package:report_it/application/entity/entity_GA/adapter_utente.dart';

import '../../application/entity/entity_GA/operatoreCUP_entity.dart';
import '../../application/entity/entity_GA/spid_entity.dart';
import '../../application/entity/entity_GA/uffPolGiud_entity.dart';
import '../../application/entity/entity_GA/utente_entity.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

class AutenticazioneDAO {
  Future<SPID?> RetrieveSPIDByEmail(String email) async {
    var ref = database.collection("SPID").where("Email", isEqualTo: email);

    var u = await ref.get().then(((value) async {
      SPID u = AdapterSpid().fromJson(value.docs.first.data());

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
        Utente u = AdapterUtente().fromJson(value.data()!);

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
        SPID u = AdapterSpid().fromJson(value.data()!);
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
        UffPolGiud u = AdapterUffPolGiud().fromJson(value.data()!);

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
        OperatoreCUP u = AdapterOperatoreCUP().fromJson(value.data()!);

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
        Utente ut = AdapterUtente().fromJson(c.data());

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
        SPID ut = AdapterSpid().fromJson(c.data());
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
        UffPolGiud ut = AdapterUffPolGiud().fromJson(c.data());
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
        OperatoreCUP ut = AdapterOperatoreCUP().fromJson(c.data());
        lista.add(ut);
      }

      return lista;
    });

    return u;
  }
}
