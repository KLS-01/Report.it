import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:report_it/data/models/AutenticazioneDAO.dart';
import 'package:report_it/data/models/prenotazione_dao.dart';
import 'package:report_it/domain/entity/entity_GA/operatoreCUP_entity.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/domain/entity/entity_GPSP/prenotazione_entity.dart';

import 'inizializza_prenotazione_test.mocks.dart';

@GenerateMocks([
  PrenotazioneDao,
  AutenticazioneDAO
], customMocks: [
  MockSpec<PrenotazioneDao>(as: #MockPrenotazioneDaoRelaxed),
  MockSpec<AutenticazioneDAO>(as: #MockAutenticazioneDAORelaxed),
])
void main() {
  late PrenotazioneDao daoP;
  late AutenticazioneDAO daoA;

  setUp(() {
    // Create mock object.
    daoP = MockPrenotazioneDao();
    daoA = MockAutenticazioneDAO();
  });

  funzioneTest(String idPrenotazione, SuperUtente utente,
      Timestamp dataPrenotazione, String psicologo) async {
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
      when(daoP.retrieveById(idPrenotazione))
          .thenAnswer((realInvocation) => Future(() {
                if (idPrenotazione == "999999999") {
                  return null;
                } else {
                  return Prenotazione(
                      id: idPrenotazione,
                      idUtente: "idUtente",
                      nomeUtente: "nomeUtente",
                      cognomeUtente: "cognomeUtente",
                      numeroUtente: "numeroUtente",
                      indirizzoUtente: "indirizzoUtente",
                      emailUtente: "emailUtente",
                      cfUtente: "cfUtente",
                      idOperatore: utente.id,
                      cap: "cap",
                      impegnativa: "impegnativa",
                      nomeASL: "nomeASL",
                      provincia: "provincia",
                      coordASL: GeoPoint(1, 2),
                      dataPrenotazione: Timestamp.fromDate(DateTime.now()),
                      descrizione: "descrizione",
                      psicologo: "psicologo");
                }
              }));

      Prenotazione? prenotazione =
          await daoP.retrieveById(idPrenotazione).then((value) => value);
      if (prenotazione == null) {
        return "prenotazione non presente sul db";
      } else {
        when(daoA.RetrieveCUPByID(utente.id))
            .thenAnswer((realInvocation) => Future((() {
                  if (utente.id == "123") {
                    return null;
                  } else {
                    return OperatoreCUP(
                        utente.id,
                        "password",
                        "email",
                        "asl",
                        GeoPoint(1, 2),
                        "capASL",
                        "cittaASL",
                        "indirizzoASL",
                        "provinciaASL",
                        "nome",
                        "cognome");
                  }
                })));
        OperatoreCUP? op = await daoA.RetrieveCUPByID(utente.id);

        if (op == null) {
          return "utente non presente nel db";
        } else {
          when(daoP.accettaPrenotazione(
                  idPrenotazione: idPrenotazione,
                  idOperatore: op.getId,
                  coordASL: op.getCoordAsl,
                  dataPrenotazione: dataPrenotazione,
                  nomeASL: op.getAsl,
                  psicologo: psicologo))
              .thenAnswer((realInvocation) => Future((() {
                    return "tutto ok";
                  })));

          daoP.accettaPrenotazione(
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

  group("inizializza_prenotazione", (() {
    test("TC_4.3_1", (() async {
      String idPrenotazione = "999999999";
      SuperUtente utente =
          SuperUtente("9K0FsSYgHkZd5j3Fz96WuCWGE0W2", TipoUtente.OperatoreCup);
      Timestamp dataPrenotazione = Timestamp.fromDate(DateTime(2025, 10, 5));
      String psicologo = "alfonso";

      assert(await funzioneTest(
                  idPrenotazione, utente, dataPrenotazione, psicologo)
              .then((value) => value) ==
          "prenotazione non presente sul db");
    }));
    test("TC_4.3_2", (() async {
      String idPrenotazione = "7Lc2mJSl9BBfN8866AHa";
      SuperUtente utente =
          SuperUtente("9K0FsSYgHkZd5j3Fz96WuCWGE0W2", TipoUtente.Utente);
      Timestamp dataPrenotazione = Timestamp.fromDate(DateTime(2025, 10, 5));
      String psicologo = "alfonso";
      assert(await funzioneTest(
                  idPrenotazione, utente, dataPrenotazione, psicologo)
              .then((value) => value) ==
          "tipo utente non valido");
    }));
    test("TC_4.3_3", (() async {
      String idPrenotazione = "7Lc2mJSl9BBfN8866AHa";
      SuperUtente utente = SuperUtente("123", TipoUtente.OperatoreCup);
      Timestamp dataPrenotazione = Timestamp.fromDate(DateTime(2025, 10, 5));
      String psicologo = "alfonso";
      assert(await funzioneTest(
                  idPrenotazione, utente, dataPrenotazione, psicologo)
              .then((value) => value) ==
          "utente non presente nel db");
    }));
    test("TC_4.3_4", (() async {
      String idPrenotazione = "7Lc2mJSl9BBfN8866AHa";
      SuperUtente utente =
          SuperUtente("9K0FsSYgHkZd5j3Fz96WuCWGE0W2", TipoUtente.OperatoreCup);
      Timestamp dataPrenotazione = Timestamp.fromDate(DateTime(2010, 10, 5));
      String psicologo = "alfonso";
      assert(await funzioneTest(
                  idPrenotazione, utente, dataPrenotazione, psicologo)
              .then((value) => value) ==
          "Data non valida");
    }));
    test("TC_4.3_5", (() async {
      String idPrenotazione = "7Lc2mJSl9BBfN8866AHa";
      SuperUtente utente =
          SuperUtente("9K0FsSYgHkZd5j3Fz96WuCWGE0W2", TipoUtente.OperatoreCup);
      Timestamp dataPrenotazione = Timestamp.fromDate(DateTime(2025, 10, 5));
      String psicologo = "Alfonso Carlo Ramires Nosepocumeno";
      assert(await funzioneTest(
                  idPrenotazione, utente, dataPrenotazione, psicologo)
              .then((value) => value) ==
          "Lunghezza nome psicologo non valida");
    }));
    test("TC_4.3_6", (() async {
      String idPrenotazione = "7Lc2mJSl9BBfN8866AHa";
      SuperUtente utente =
          SuperUtente("9K0FsSYgHkZd5j3Fz96WuCWGE0W2", TipoUtente.OperatoreCup);
      Timestamp dataPrenotazione = Timestamp.fromDate(DateTime(2025, 10, 5));
      String psicologo = "alfonso";
      assert(await funzioneTest(
                  idPrenotazione, utente, dataPrenotazione, psicologo)
              .then((value) => value) ==
          "Corretto");
    }));
  }));
}
