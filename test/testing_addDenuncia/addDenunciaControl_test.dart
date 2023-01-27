import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:report_it/data/models/denuncia_dao.dart';
import 'package:report_it/domain/entity/entity_GD/categoria_denuncia.dart';
import 'package:report_it/domain/entity/entity_GD/denuncia_entity.dart';
import 'package:report_it/domain/entity/entity_GD/stato_denuncia.dart';

import 'addDenunciaControl_test.mocks.dart';

// @GenerateMocks([
//   DenunciaDao
// ], customMocks: [
//   MockSpec<DenunciaDao>(as: #MockDenunciaDaoRelaxed),
// ])

void main() {
  late DenunciaDao dao;
  late MockUser user;
  late MockFirebaseAuth auth;

  setUp(() {
    dao = MockDenunciaDao();
    user = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    auth = MockFirebaseAuth(mockUser: user, signedIn: true);
  });

  funzioneTest(
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
      required bool? alreadyFiled}) {
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
    if (!regexIndirizzo.hasMatch(indirizzoDenunciante)) {
      return ("Il formato dell’indirizzo non è valido");
    } else if (indirizzoDenunciante.length > 50) {
      return ("La lunghezza dell’indirizzo non è valida");
    }
    if (!regexCap.hasMatch(capDenunciante)) {
      return ("Il formato del CAP non è rispettato");
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
    if (tipoDocDenunciante == "Carta Identita" ||
        tipoDocDenunciante == "Patente") {
      //aggiungere
    } else {
      return ("Tipo documento non rispettato");
    }
    String numero = numeroDocDenunciante!;
    if (numero.length > 15) {
      //aggiungere
      return ("La lunghezza del nunero del documento è errata");
    }
    if (scadenzaDocDenunciante.toDate().compareTo(DateTime.now()) <= 0) {
      return ("Errore il documento già è scaduto");
    }
    try {
      CategoriaDenuncia.values.byName(categoriaDenuncia.name);
    } catch (e) {
      return ("La categoria di discriminazione inserita è sconosciuta");
    }
    if (nomeVittima.length > 30) {
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
        numeroDocDenunciante: numeroDocDenunciante!,
        scadenzaDocDenunciante: scadenzaDocDenunciante,
        categoriaDenuncia: categoriaDenuncia,
        nomeVittima: nomeVittima,
        denunciato: denunciato,
        descrizione: descrizione,
        cognomeVittima: cognomeVittima,
        alreadyFiled: alreadyFiled!,
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
/*
    when(dao.addDenuncia(denuncia).then((realInvocation) => Future((
        (){
          return "checco";
        }
    ))));
    dao.addDenuncia(denuncia).then((DocumentReference<Object?> id) {
      denuncia.setId = id.id;
      DenunciaDao().updateId(denuncia.getId);
    });

 */
    return "OK";
  }

  group("AddDenuncia", () {});
}
