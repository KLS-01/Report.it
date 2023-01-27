import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:report_it/data/models/AutenticazioneDAO.dart';
import 'package:report_it/domain/entity/entity_GA/spid_entity.dart';
import 'package:report_it/domain/entity/entity_GD/adapter_denuncia.dart';
import 'package:report_it/domain/entity/entity_GD/categoria_denuncia.dart';
import 'package:report_it/domain/entity/entity_GD/stato_denuncia.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/domain/entity/entity_GA/uffPolGiud_entity.dart';

import "../../data/models/denuncia_dao.dart";
import '../entity/entity_GD/denuncia_entity.dart';
import '../entity/entity_GA/super_utente.dart';

class DenunciaController {
  DenunciaDao denunciaDao = DenunciaDao();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Denuncia jsonToDenuncia(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return AdapterDenuncia().fromJson(json.data());
  }

  Denuncia jsonToDenunciaDettagli(Map<String, dynamic> json) {
    return AdapterDenuncia().fromJson(json);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> generaStreamDenunciaByUtente(
      SuperUtente utente) {
    return DenunciaDao().generaStreamDenunceByUtente(utente);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> generaStreamDenunciaByStatoAndCap(
      StatoDenuncia stato, SuperUtente utente) {
    return DenunciaDao().generaStreamDenunceByStatoAndCap(stato, utente.cap!);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> generaStreamDenunciaById(
      String id) {
    return DenunciaDao().generaStreamDenunceById(id);
  }

  Future<List<Denuncia>> visualizzaDenunceByStato(StatoDenuncia stato) {
    return denunciaDao.retrieveByStato(stato);
  }

  Future<Denuncia?> visualizzaDenunciaById(
      String idDenuncia, SuperUtente utente) async {
    Denuncia? d = await denunciaDao.retrieveById(idDenuncia);
    if (d == null) {
      return d;
    } else if (utente.tipo == TipoUtente.Utente) {
      return d;
    } else {
      if (d.statoDenuncia == StatoDenuncia.NonInCarico) {
        return d;
      } else if (d.idUff == utente.id) {
        return d;
      } else {
        return null;
      }
    }
  }

  Future<String?> addDenunciaControl(
      {required String nomeDenunciante,
      required String cognomeDenunciante,
      required String indirizzoDenunciante,
      required String capDenunciante,
      required String provinciaDenunciante,
      required String cellulareDenunciante,
      required String emailDenunciante,
      required String? tipoDocDenunciante,
      required String? numeroDocDenunciante,
      required Timestamp scadenzaDocDenunciante,
      required CategoriaDenuncia categoriaDenuncia,
      required String nomeVittima,
      required String denunciato,
      required String descrizione,
      required String cognomeVittima,
      required bool consenso,
      required bool? alreadyFiled}) async {
    Timestamp today = Timestamp.now();
    final regexEmail = RegExp(r"^[A-z0-9\.\+_-]+@[A-z0-9\._-]+\.[A-z]{2,6}$");
    //   r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final regexIndirizzo = RegExp(r"^[a-zA-Z+\s]+[,]?\s?[0-9]+$");
    final regexCap = RegExp(r"^[0-9]{5}$");
    final regexProvincia = RegExp(r"^[a-zA-Z]{2}$");
    final regexCellulare =
        RegExp(r"^((00|\+)39[\. ]??)??3\d{2}[\. ]??\d{6,7}$");

    final User? user = auth.currentUser;
    if (user == null) {
      print("Non loggato");
    } else {
      print("Ok");
    }

    if (nomeDenunciante.length > 30) {
      //aggiungere
      return ("Lunghezza nome denunciante non è valida");
    }
    if (cognomeDenunciante.length > 30) {
      //aggiungere
      return ("Lunghezza cognome denunciante non è valida");
    }
    if (!regexCap.hasMatch(capDenunciante)) {
      return ("Il formato del CAP non è rispettato");
    }
    if (!regexIndirizzo.hasMatch(indirizzoDenunciante)) {
      return ("Il formato dell'indirizzo non è rispettato");
    }
    if (!regexProvincia.hasMatch(provinciaDenunciante)) {
      return ("Il formato della provincia non è rispettato");
    }
    if (!regexCellulare.hasMatch(cellulareDenunciante)) {
      return ("Il formato del numero di cellulare non è rispettato");
    }
    if (!regexEmail.hasMatch(emailDenunciante)) {
      return ("Il formato della e-mail non è rispettato");
    }
    print(tipoDocDenunciante);

    if (tipoDocDenunciante == "Carta Identita" ||
        tipoDocDenunciante == "Patente") {
      //aggiungere
    } else {
      return ("Tipo documento non rispettato");
    }
    String numero = numeroDocDenunciante!;

    if (numero.length > 15) {
      //aggiungere
      try {
        CategoriaDenuncia.values.byName(categoriaDenuncia.name);
      } catch (e) {
        return ("La categoria di discriminazione inserita è sconosciuta");
      }
      return ("La lunghezza del nome della vittima non è valida");
    }
    if (denunciato.length > 60) {
      return ("La lunghezza del campo denunciato non è valida");
    }
    if (descrizione.length > 1000) {
      return ("La lunghezza della descrizione non è valida");
    }
    if (cognomeVittima.length > 30) {
      return ("La lunghezza del cognome della vittima non è valida");
    }
    if (consenso == false) {
      return ("Il campo del consenso non è valido");
    }
    if (alreadyFiled == null) {
      return ("Il campo che indica se la pratica è stata già precedentemente archiviata non è valido");
    }

    Denuncia denuncia = Denuncia(
        id: null,
        nomeDenunciante: nomeDenunciante,
        cognomeDenunciante: cognomeDenunciante,
        indirizzoDenunciante: indirizzoDenunciante,
        capDenunciante: capDenunciante,
        provinciaDenunciante: provinciaDenunciante,
        cellulareDenunciante: cellulareDenunciante,
        emailDenunciante: emailDenunciante,
        tipoDocDenunciante: tipoDocDenunciante!,
        numeroDocDenunciante: numeroDocDenunciante,
        scadenzaDocDenunciante: scadenzaDocDenunciante,
        categoriaDenuncia: categoriaDenuncia,
        nomeVittima: nomeVittima,
        denunciato: denunciato,
        descrizione: descrizione,
        cognomeVittima: cognomeVittima,
        alreadyFiled: alreadyFiled,
        consenso: consenso,
        cognomeUff: null,
        coordCaserma: null,
        dataDenuncia: today,
        idUff: null,
        idUtente: user!.uid,
        nomeCaserma: null,
        nomeUff: null,
        statoDenuncia: StatoDenuncia.NonInCarico,
        tipoUff: null,
        indirizzoCaserma: null,
        gradoUff: null);

    DenunciaDao().addDenuncia(denuncia).then((String id) {
      denuncia.setId = id;
      DenunciaDao().updateId(denuncia.getId);
    });
    return "OK";
  }

  Future<String> accettaDenuncia(Denuncia denuncia, SuperUtente utente) async {
    if (utente.tipo != TipoUtente.UffPolGiud) {
      return "tipo utente non valido";
    } else {
      UffPolGiud? uff =
          await AutenticazioneDAO().RetrieveUffPolGiudByID(utente.id);

      if (uff == null) {
        return "utente non presente nel db";
      } else {
        // ignore: unnecessary_null_comparison
        if (denuncia == null) {
          return "denuncia non presente sul db"; //conforme all'annessa funzione di testing
        } else {
          DenunciaDao().accettaDenuncia(
              denuncia.id!,
              uff.coordinate,
              uff.id.trim(),
              uff.nomeCaserma,
              uff.nome,
              uff.cognome,
              uff.tipoUff,
              uff.grado);
          return "Corretto";
        }
      }
    }
  }

  chiudiDenuncia(Denuncia denuncia, SuperUtente utente) async {
    if (utente.tipo != TipoUtente.UffPolGiud) {
      return;
    } else {
      if (denuncia.idUff != utente.id) {
        return;
      } else {
        return await DenunciaDao().updateAttribute(
            denuncia.id!, "Stato", StatoDenuncia.Chiusa.name.toString());
      }
    }
  }

  Future<SPID?> retrieveSpidByUtente(SuperUtente utente) async {
    Future<SPID?> spidUtente = AutenticazioneDAO().RetrieveSPIDByID(utente.id);
    return spidUtente;
  }
}
