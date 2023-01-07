import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:report_it/data/models/AutenticazioneDAO.dart';
import 'package:report_it/data/models/prenotazione_dao.dart';
import 'package:report_it/domain/entity/operatoreCUP_entity.dart';
import 'package:report_it/domain/entity/prenotazione_entity.dart';
import 'package:report_it/domain/entity/super_utente.dart';
import 'package:report_it/domain/entity/tipo_utente.dart';
import 'package:report_it/domain/entity/uffPolGiud_entity.dart';

class PrenotazioneController {
  PrenotazioneDao prenotazioneDao = PrenotazioneDao();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> addPrenotazioneControl(
      {required utente,
      required cap,
      required provincia,
      required impegnativa}) async {
    if (utente == null) {
      print("Non loggato");
    } else {
      print("Ok");
    }

    Prenotazione prenotazione = Prenotazione(
        id: null,
        idUtente: utente!.id,
        cap: cap,
        provincia: provincia,
        idOperatore: null,
        coordASL: null,
        nomeASL: null,
        dataPrenotazione: null,
        impegnativa: null);

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

  Future<bool> inizializzaPrenotazione(
      String idPrenotazione,
      SuperUtente utente,
      GeoPoint coordASL,
      Timestamp dataPrenotazione,
      String nomeASL) async {
    if (utente.tipo != TipoUtente.OperatoreCup) {
      return false;
    } else {
      Prenotazione? prenotazione =
          await prenotazioneDao.retrieveById(idPrenotazione);
      if (prenotazione == null) {
        return false;
      } else {
        OperatoreCUP? op = await RetrieveCUPByID(utente.id);
        if (op == null) {
          return false;
        } else {
          prenotazioneDao.accettaPrenotazione(
              idPrenotazione: idPrenotazione,
              idOperatore: op.id,
              coordASL: coordASL,
              dataPrenotazione: dataPrenotazione,
              nomeASL: nomeASL);
          return true;
        }
      }
    }
  }
}
