import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:report_it/data/models/AutenticazioneDAO.dart';
import 'package:report_it/data/models/prenotazione_dao.dart';
import 'package:report_it/domain/entity/entity_GA/operatoreCUP_entity.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/domain/entity/entity_GPSP/adapter_prenotazione.dart';
import 'package:report_it/domain/entity/entity_GPSP/prenotazione_entity.dart';

class PrenotazioneController {
  PrenotazioneDao prenotazioneDao = PrenotazioneDao();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> addPrenotazioneControl({
    required utente,
    required nome,
    required cognome,
    required numeroTelefono,
    required indirizzo,
    required email,
    required cf,
    required cap,
    required provincia,
    required impegnativa,
    required descrizione,
  }) async {
    if (utente == null) {
      print("Non loggato");
    } else {
      print("Ok");
    }

    Prenotazione prenotazione = Prenotazione(
        id: null,
        idUtente: utente!.id,
        nomeUtente: nome,
        cognomeUtente: cognome,
        numeroUtente: numeroTelefono,
        emailUtente: email,
        cfUtente: cf,
        indirizzoUtente: indirizzo,
        cap: cap,
        provincia: provincia,
        idOperatore: null,
        coordASL: null,
        nomeASL: null,
        dataPrenotazione: null,
        impegnativa: null,
        psicologo: null,
        descrizione: descrizione);

    String? result;
    PrenotazioneDao.addPrenotazione(prenotazione)
        .then((DocumentReference<Object?> id) {
      prenotazione.setId = id.id;
      PrenotazioneDao.updateId(prenotazione.getId);
      uploadImpegnativa(prenotazione.getId, impegnativa);
      result = prenotazione.getId;
      return result;
    });

    return result;
  }

  void uploadImpegnativa(
      String idPrenotazione, FilePickerResult? fileResult) async {
    File file = File(fileResult!.files.single.path!);
    String fileName = "Impegnativa_$idPrenotazione.pdf";
    print(fileName);
    print('${file.readAsBytesSync()}');

    String? url = await PrenotazioneDao.uploadImpegnativa(
        file.readAsBytesSync(), fileName);
    PrenotazioneDao.updateAttribute(idPrenotazione, "Impegnativa", url);
  }

  Future<List<Prenotazione>> visualizzaAttiveByUtente(
      SuperUtente? utente) async {
    if (utente == null) {
      print("User Error");
    } else {
      List<Prenotazione> listaAttive =
          await prenotazioneDao.retrieveByUtente(utente.id);
      listaAttive.removeWhere((element) => element.dataPrenotazione != null);
      print(listaAttive);
      return listaAttive;
    }
    return Future.error(StackTrace);
  }

  Future<List<Prenotazione>> visualizzaStoricoByUtente(
      SuperUtente? utente) async {
    if (utente == null) {
      print("User Error");
    } else {
      List<Prenotazione> listaAttive =
          await prenotazioneDao.retrieveByUtente(utente.id);
      listaAttive.removeWhere((element) => element.dataPrenotazione == null);

      return listaAttive;
    }
    return Future.error(StackTrace);
  }

  Future<List<Prenotazione>> visualizzaStoricoByOperatore(
      SuperUtente? operatore) async {
    if (operatore == null) {
      print("User Error");
    } else {
      if (operatore.tipo != TipoUtente.OperatoreCup) {
        return Future.error(StackTrace);
      } else {
        List<Prenotazione> listaAccettate =
            await prenotazioneDao.retrieveByOperatore(operatore.id);
        listaAccettate
            .removeWhere((element) => element.dataPrenotazione == null);

        return listaAccettate;
      }
    }
    return Future.error(StackTrace);
  }

  Future<List<Prenotazione>> visualizzaAttive(SuperUtente? utente) async {
    if (utente == null) {
      print("User Error");
    } else {
      List<Prenotazione> listaAttive = await prenotazioneDao.retrieveAttive();
      //print("Print Application layer: $listaAttive");
      return listaAttive;
    }
    return Future.error(StackTrace);
  }

  Future<String> inizializzaPrenotazione(String idPrenotazione,
      SuperUtente utente, Timestamp dataPrenotazione, String psicologo) async {
    if (psicologo.length > 20 || psicologo.isEmpty) {
      return "Lunghezza nome psicologo non valida";
    }

    final timestamp1 = DateTime.now().millisecondsSinceEpoch;

    if (dataPrenotazione.compareTo(Timestamp.fromDate(DateTime.now())) < 0) {
      return "Data non valida";
    }

    if (utente.tipo != TipoUtente.OperatoreCup) {
      return "tipo utente non valido";
    } else {
      Prenotazione? prenotazione =
          await prenotazioneDao.retrieveById(idPrenotazione);
      if (prenotazione == null) {
        return "prenotazione non presente sul db";
      } else {
        OperatoreCUP? op = await AutenticazioneDAO().RetrieveCUPByID(utente.id);
        if (op == null) {
          return "utente non presente nel db";
        } else {
          prenotazioneDao.accettaPrenotazione(
              idPrenotazione: idPrenotazione,
              idOperatore: op.getId,
              coordASL: op.getCoordAsl,
              dataPrenotazione: dataPrenotazione,
              nomeASL: op.getAsl,
              psicologo: psicologo);
          return "Corretto";
        }
      }
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> generaStreamAttive(
      SuperUtente operatore) {
    if (operatore.tipo == TipoUtente.OperatoreCup) {
      print("Flag ${operatore.id}");
      return prenotazioneDao.retrieveStreamAttive(operatore);
    } else {
      throw ("Utente non operatore");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> generaStreamAttiveUtente(
      SuperUtente utente) {
    return prenotazioneDao.retrieveStreamByUtente(utente.id);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> generaStreamStoricoOperatore(
      SuperUtente operatore) {
    if (operatore.tipo == TipoUtente.OperatoreCup) {
      return prenotazioneDao.retrieveStreamByOperatore(operatore.id);
    } else {
      throw ("L'utente non è un operatore");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> generaStreamStoricoUtente(
      SuperUtente utente) {
    return prenotazioneDao.retrieveStreamByUtente(utente.id);
  }

  Prenotazione prenotazioneFromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return AdapterPrenotazione().fromJson(json.data());
  }

  Future<Prenotazione?> retrieveById(String idPrenotazione) async {
    return await prenotazioneDao.retrieveById(idPrenotazione);
  }
}
