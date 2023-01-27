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

@GenerateMocks([
  DenunciaDao
], customMocks: [
  MockSpec<DenunciaDao>(as: #MockDenunciaDaoRelaxed),
])
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
    } else {}

    if (nomeDenunciante.length > 30) {
      //aggiungere
      return ("Lunghezza nome denunciante non è valida");
    }
    if (cognomeDenunciante.length > 30) {
      //aggiungere
      return ("Lunghezza cognome denunciante non è valida");
    }
    if (indirizzoDenunciante.length > 50) {
      return ("La lunghezza dell’indirizzo non è valida");
    }
    if (!regexIndirizzo.hasMatch(indirizzoDenunciante)) {
      return ("Il formato dell’indirizzo non è valido");
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

    if ((numeroDocDenunciante?.length)! > 15) {
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

    when(dao.addDenuncia(denuncia)).thenAnswer((realInvocation) => Future((() {
          return "someuid";
        })));

    dao.addDenuncia(denuncia).then((String id) {
      denuncia.setId = id;
      DenunciaDao().updateId(denuncia.getId);
    });

    return "OK";
  }

  group("AddDenuncia", () {
    test("TC_GD.1.1_1 ", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante = "Via Rossi";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "12345678";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "Ortiz";
      bool consenso = true;
      bool? alreadyFiled = false;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "Il formato dell’indirizzo non è valido");
    }));

    test("TC_GD.1.1_2", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante =
          "Via Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci, 46";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "12345678";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "Ortiz";
      bool consenso = true;
      bool? alreadyFiled = false;
      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "La lunghezza dell’indirizzo non è valida");
    }));
    test("TC_GD.1.1_3", (() async {
      String capDenunciante = "84016777";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante = "Via Traversa Taurano, 46";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "12345678";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "Ortiz";
      bool consenso = true;
      bool? alreadyFiled = false;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "Il formato del CAP non è rispettato");
    }));
    test("TC_GD.1.1_4", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante = "Via Traversa Taurano, 46";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110704543534534534";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "12345678";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "Ortiz";
      bool consenso = true;
      bool? alreadyFiled = false;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "Il formato del numero di cellulare non è rispettato");
    }));

    test("TC_GD.1.1_5", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante = "Via Traversa Taurano, 46";
      String provinciaDenunciante = "SUS";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "12345678";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "Ortiz";
      bool consenso = true;
      bool? alreadyFiled = false;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "Il formato della provincia non è rispettato");
    }));

    test("TC_GD.1.1_6", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante = "Via Traversa Taurano, 46";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "mailSbagliata@dominioincompleto";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "12345678";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "Ortiz";
      bool consenso = true;
      bool? alreadyFiled = false;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "Il formato della e-mail non è rispettato");
    }));

    //IL TEST 7 NON SI PUÒ FARE

    test("TC_GD.1.1_8", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante = "Via Traversa Taurano, 46";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "12345678";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "fiefhiueahrfiuhaeiurfhiuaehfiuaehrfiuhea";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "Ortiz";
      bool consenso = true;
      bool? alreadyFiled = false;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "La lunghezza del nome della vittima non è valida");
    }));

    test("TC_GD.1.1_9", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante = "Via Traversa Taurano, 46";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "12345678";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "edafaerfaerfeahfheifhiuehfuihaygvyjgjhygjygj";
      bool consenso = true;
      bool? alreadyFiled = false;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "La lunghezza del cognome della vittima non è valida");
    }));

    test("TC_GD.1.1_10", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante = "Via Traversa Taurano, 46";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "12345678";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato =
          "Giuseppe Fabio Pierferdinando Santini Quondamangelomaria Garibaldi";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "Ortiz";
      bool consenso = true;
      bool? alreadyFiled = false;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "La lunghezza del campo denunciato non è valida");
    }));

    test("TC_GD.1.1_11", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante = "Via Traversa Taurano, 46";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "12345678";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sed ipsum at mauris pulvinar auctor. Duis sit amet quam tellus. Suspendisse potenti. Cras leo magna, hendrerit vel nisi eget, egestas fringilla tellus. Cras luctus lacus augue, eu accumsan ante dictum et. Nulla tincidunt ligula ut ultrices laoreet. "
          "Aenean congue nec mi a rhoncus. Donec ligula metus, auctor in libero et, maximus pharetra mi. Integer felis dui, accumsan in diam vitae, placerat sollicitudin turpis. Curabitur at augue varius urna tristique lobortis sed quis purus. Ut ultricies, arcu ut luctus fringilla, ante ligula vulputate dui, vel accumsan erat libero ac magna. Aenean ut laoreet mauris, eu tempus tortor. Nullam venenatis risus ut ex suscipit gravida. In imperdiet tortor quis neque pellentesque porta "
          "ac vitae dolor. Ut sagittis ex turpis, sed vulputate mauris scelerisque at.Proin ac massa ut elit suscipit dictum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lobortis ultrices mauris, et eleifend.";
      String cognomeVittima = "Ortiz";
      bool consenso = true;
      bool? alreadyFiled = false;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "La lunghezza della descrizione non è valida");
    }));

    test("TC_GD.1.1_12", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante = "Via Traversa Taurano, 46";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "12345678";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "Ortiz";
      bool consenso = false;
      bool? alreadyFiled = false;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "Il campo del consenso non è valido");
    }));

    test("TC_GD.1.1_13", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante = "Via Traversa Taurano, 46";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "12345678";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "Ortiz";
      bool consenso = true;
      bool? alreadyFiled = null;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "Il campo che indica se la pratica è stata già precedentemente archiviata non è valido");
    }));

    test("TC_GD.1.1_14", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante =
          "Albertofeargewrgergfawrtegwegweartgvrwtgvterwgveartw";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante = "Via Traversa Taurano, 46";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "12345678";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "Ortiz";
      bool consenso = true;
      bool? alreadyFiled = false;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "Lunghezza nome denunciante non è valida");
    }));

    test("TC_GD.1.1_15", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante =
          "Genoveseefgwefgwerfgewgfwerfgewgfewrtfgerfgrewfgew";
      String indirizzoDenunciante = "Via Traversa Taurano, 46";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "12345678";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "Ortiz";
      bool consenso = true;
      bool? alreadyFiled = false;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "Lunghezza cognome denunciante non è valida");
    }));

    test("TC_GD.1.1_16", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante = "Via Traversa Taurano, 46";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identitaresgsrtg";
      String? numeroDocDenunciante = "12345678";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "Ortiz";
      bool consenso = true;
      bool? alreadyFiled = false;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "Tipo documento non rispettato");
    }));

    test("TC_GD.1.1_17", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante = "Via Traversa Taurano, 46";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "123456785667rthrthdthrgh";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "Ortiz";
      bool consenso = true;
      bool? alreadyFiled = false;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "La lunghezza del nunero del documento è errata");
    }));

    test("TC_GD.1.1_18", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante = "Via Traversa Taurano, 46";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "123456";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2010-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "Ortiz";
      bool consenso = true;
      bool? alreadyFiled = false;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "Errore il documento già è scaduto");
    }));

    test("TC_GD.1.1_19", (() async {
      String capDenunciante = "84016";
      String nomeDenunciante = "Alberto";
      String cognomeDenunciante = "Genovese";
      String indirizzoDenunciante = "Via Traversa Taurano, 46";
      String provinciaDenunciante = "SA";
      String cellulareDenunciante = "+393802110703";
      String emailDenunciante = "g.ortiz@gmail.com";
      String? tipoDocDenunciante = "Carta Identita";
      String? numeroDocDenunciante = "123456";
      Timestamp scadenzaDocDenunciante =
          Timestamp.fromDate(DateTime.parse("2030-12-12"));
      CategoriaDenuncia categoriaDenuncia = CategoriaDenuncia.Colore;
      String nomeVittima = "Gonzalo";
      String denunciato = "Fabio Santini";
      String descrizione =
          "Il signor Fabio Santini il giorno 20/03/2023 mi ha negato il servizio nel suo ristorante usando come motivazione che essendo di colore non potessi permettermi di pagare il conto.";
      String cognomeVittima = "Ortiz";
      bool consenso = true;
      bool? alreadyFiled = false;

      assert(await funzioneTest(
              cognomeDenunciante: cognomeDenunciante,
              indirizzoDenunciante: indirizzoDenunciante,
              provinciaDenunciante: provinciaDenunciante,
              cellulareDenunciante: cellulareDenunciante,
              emailDenunciante: emailDenunciante,
              tipoDocDenunciante: tipoDocDenunciante,
              numeroDocDenunciante: numeroDocDenunciante,
              scadenzaDocDenunciante: scadenzaDocDenunciante,
              categoriaDenuncia: categoriaDenuncia,
              nomeVittima: nomeVittima,
              denunciato: denunciato,
              descrizione: descrizione,
              cognomeVittima: cognomeVittima,
              consenso: consenso,
              alreadyFiled: alreadyFiled,
              nomeDenunciante: nomeDenunciante,
              capDenunciante: capDenunciante) ==
          "OK");
    }));
  });
}
