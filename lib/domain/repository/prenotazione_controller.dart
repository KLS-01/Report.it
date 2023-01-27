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
    required String nome,
    required String cognome,
    required String numeroTelefono,
    required String indirizzo,
    required String email,
    required String cf,
    required String cap,
    required String provincia,
    required FilePickerResult impegnativa,
    required String descrizione,
  }) async {
    final regexEmail = RegExp(r"^[A-z0-9\.\+_-]+@[A-z0-9\._-]+\.[A-z]{2,6}$");
    final regexIndirizzo = RegExp(r"^[a-zA-Z+\s]+[,]?\s?[0-9]+$");
    final regexCap = RegExp(r"^[0-9]{5}$");
    final regexProvincia = RegExp(r"^[a-zA-Z]{2}$");
    final regexCellulare =
        RegExp(r"^((00|\+)39[\. ]??)??3\d{2}[\. ]??\d{6,7}$");
    final regexCF = RegExp(
        r"^([A-Z]{6}[0-9LMNPQRSTUV]{2}[ABCDEHLMPRST]{1}[0-9LMNPQRSTUV]{2}[A-Z]{1}[0-9LMNPQRSTUV]{3}[A-Z]{1})$|([0-9]{11})$");

    Prenotazione prenotazione = Prenotazione(
        id: null,
        idUtente: auth.currentUser!.uid,
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
    int dim = impegnativa.files.first.bytes!.lengthInBytes;
    if (nome.length < 2 || nome.length > 30) {
      return "Errore: lunghezza nome non valida";
    } else if (cognome.length < 2 || cognome.length > 30) {
      return "Errore: lunghezza cognome non valida";
    } else if (!regexCellulare.hasMatch(numeroTelefono)) {
      return "Errore: formato numero di telefono non rispettato";
    } else if (!regexIndirizzo.hasMatch(indirizzo)) {
      return "Errore: formato indirizzo non rispettato";
    } else if (!regexEmail.hasMatch(email)) {
      return "Errore: formato indirizzo email non rispettato";
    } else if (!regexCF.hasMatch(cf)) {
      return "Errore: formato codice fiscale non rispettato";
    } else if (!regexCap.hasMatch(cap)) {
      return "Errore: formato CAP non rispettato";
    } else if (!regexProvincia.hasMatch(provincia)) {
      return "Errore: formato provincia non rispettato";
    } else if (descrizione.length < 10 || descrizione.length > 500) {
      return "Errore: lunghezza descrizione non valida";
    } else if (dim <= 0 || dim > 20971520) {
      return "Errato: dimensione file non valida";
    } else if (impegnativa.files.first.extension != "pdf") {
      return "Errato: estensione del file non supportata (caricare un file in formato pdf)";
    } else {
      String result = "false";
      prenotazioneDao
          .addPrenotazione(prenotazione)
          .then((DocumentReference<Object?> id) {
        prenotazione.setId = id.id;
        prenotazioneDao.updateId(prenotazione.getId);
        uploadImpegnativa(prenotazione.getId, impegnativa);
        result = "true";
        return result;
      });
      return result;
    }
  }

  void uploadImpegnativa(
      String idPrenotazione, FilePickerResult? fileResult) async {
    File file = File(fileResult!.files.single.path!);
    String fileName = "Impegnativa_$idPrenotazione.pdf";
    print(fileName);
    print('${file.readAsBytesSync()}');

    String? url = await prenotazioneDao.uploadImpegnativa(
        file.readAsBytesSync(), fileName);
    prenotazioneDao.updateAttribute(idPrenotazione, "Impegnativa", url);
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

  Future<bool> inizializzaPrenotazione(String idPrenotazione,
      SuperUtente utente, Timestamp dataPrenotazione, String psicologo) async {
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
              idOperatore: op.getId,
              coordASL: op.getCoordAsl,
              dataPrenotazione: dataPrenotazione,
              nomeASL: op.getAsl,
              psicologo: psicologo);
          return true;
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
