import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:report_it/data/models/prenotazione_dao.dart';
import 'package:report_it/domain/entity/entity_GPSP/prenotazione_entity.dart';
import 'package:report_it/domain/repository/prenotazione_controller.dart';

import 'add_prenotazione_control_test.mocks.dart';

@GenerateMocks([
  PrenotazioneDao,
  PrenotazioneController
], customMocks: [
  MockSpec<PrenotazioneDao>(as: #MockPrenotazioneDaoRelaxed),
  MockSpec<PrenotazioneController>(as: #MockPrenotazioneControllerRelaxed),
])
void main() {
  late PrenotazioneDao dao;
  late MockUser user;
  late MockFirebaseAuth auth;
  late PrenotazioneController control;
  setUp(() {
    // Create mock object.
    dao = MockPrenotazioneDao();
    control = MockPrenotazioneController();

    user = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    auth = MockFirebaseAuth(mockUser: user, signedIn: true);
  });

  funzioneTest({
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
  }) {
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
    int dim = impegnativa.files.first.size;
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
    }
    String result = "true";
    when(dao.addPrenotazione(prenotazione))
        .thenAnswer((realInvocation) => Future((() {
              result = "true";
              return "someuid";
            })));

    dao.addPrenotazione(prenotazione).then((String id) {
      prenotazione.setId = id;
      dao.updateId(prenotazione.getId);
      control.uploadImpegnativa(prenotazione.getId, impegnativa);
      result = "true";
      return result;
    });
    return result;
  }

  group("Inoltra prenotazione", () {
    test("TC_GPSP.1.1_1", (() {
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(
          name: "impegnativa.pdf",
          size: 5000000,
          bytes: Uint8List.fromList([10, 20, 30])));
      var file = FilePickerResult(files);
      var nome = "Gianmarcoantonioaureliocesareaugusto";
      var cognome = "Rossi";
      var numeroTelefono = "3345421403";
      var indirizzo = "Via del Campo,2";
      var email = "test@gmail.com";
      var cf = "DLCNCL02T32I197R";
      var cap = "82019";
      var provincia = "BN";
      var descrizione =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci. Sed nunc neque, faucibus vel feugiat eu, " +
              "fermentum ornare metus. Etiam volutpat sed lacus eu efficitur. Sed tincidunt mauris id cursus rutrum. Praesent pellentesque ultrices lectus, vel porta felis eleifend sed. Etiam ac molestie eros. ";

      assert(funzioneTest(
              nome: nome,
              cognome: cognome,
              cf: cf,
              numeroTelefono: numeroTelefono,
              indirizzo: indirizzo,
              provincia: provincia,
              cap: cap,
              email: email,
              descrizione: descrizione,
              impegnativa: file) ==
          "Errore: lunghezza nome non valida");
    }));

    test("TC_GPSP.1.1_2", (() {
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(
          name: "impegnativa.pdf",
          size: 5000000,
          bytes: Uint8List.fromList([10, 20, 30])));
      var file = FilePickerResult(files);
      var nome = "Luca";
      var cognome = "Delgado Garcia Ramirez Guantanamera De La Sierna";
      var numeroTelefono = "3345421403";
      var indirizzo = "Via del Campo,2";
      var email = "test@gmail.com";
      var cf = "DLCNCL02T32I197R";
      var cap = "82019";
      var provincia = "BN";
      var descrizione =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci. Sed nunc neque, faucibus vel feugiat eu, " +
              "fermentum ornare metus. Etiam volutpat sed lacus eu efficitur. Sed tincidunt mauris id cursus rutrum. Praesent pellentesque ultrices lectus, vel porta felis eleifend sed. Etiam ac molestie eros. ";

      assert(funzioneTest(
              nome: nome,
              cognome: cognome,
              cf: cf,
              numeroTelefono: numeroTelefono,
              indirizzo: indirizzo,
              provincia: provincia,
              cap: cap,
              email: email,
              descrizione: descrizione,
              impegnativa: file) ==
          "Errore: lunghezza cognome non valida");
    }));

    test("TC_GPSP.1.1_3", (() {
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(
          name: "impegnativa.pdf",
          size: 5000000,
          bytes: Uint8List.fromList([10, 20, 30])));
      var file = FilePickerResult(files);
      var nome = "Luca";
      var cognome = "Rossi";
      var numeroTelefono = "334543";
      var indirizzo = "Via del Campo,2";
      var email = "test@gmail.com";
      var cf = "DLCNCL02T32I197R";
      var cap = "82019";
      var provincia = "BN";
      var descrizione =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci. Sed nunc neque, faucibus vel feugiat eu, " +
              "fermentum ornare metus. Etiam volutpat sed lacus eu efficitur. Sed tincidunt mauris id cursus rutrum. Praesent pellentesque ultrices lectus, vel porta felis eleifend sed. Etiam ac molestie eros. ";

      assert(funzioneTest(
              nome: nome,
              cognome: cognome,
              cf: cf,
              numeroTelefono: numeroTelefono,
              indirizzo: indirizzo,
              provincia: provincia,
              cap: cap,
              email: email,
              descrizione: descrizione,
              impegnativa: file) ==
          "Errore: formato numero di telefono non rispettato");
    }));

    test("TC_GPSP.1.1_4", (() {
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(
          name: "impegnativa.pdf",
          size: 5000000,
          bytes: Uint8List.fromList([10, 20, 30])));
      var file = FilePickerResult(files);
      var nome = "Luca";
      var cognome = "Rossi";
      var numeroTelefono = "3802061904";
      var indirizzo = "454g";
      var email = "test@gmail.com";
      var cf = "DLCNCL02T32I197R";
      var cap = "82019";
      var provincia = "BN";
      var descrizione =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci. Sed nunc neque, faucibus vel feugiat eu, " +
              "fermentum ornare metus. Etiam volutpat sed lacus eu efficitur. Sed tincidunt mauris id cursus rutrum. Praesent pellentesque ultrices lectus, vel porta felis eleifend sed. Etiam ac molestie eros. ";

      assert(funzioneTest(
              nome: nome,
              cognome: cognome,
              cf: cf,
              numeroTelefono: numeroTelefono,
              indirizzo: indirizzo,
              provincia: provincia,
              cap: cap,
              email: email,
              descrizione: descrizione,
              impegnativa: file) ==
          "Errore: formato indirizzo non rispettato");
    }));

    test("TC_GPSP.1.1_5", (() {
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(
          name: "impegnativa.pdf",
          size: 5000000,
          bytes: Uint8List.fromList([10, 20, 30])));
      var file = FilePickerResult(files);
      var nome = "Luca";
      var cognome = "Rossi";
      var numeroTelefono = "3345431203";
      var indirizzo = "Via del Campo,2";
      var email = "test.email";
      var cf = "DLCNCL02T32I197R";
      var cap = "82019";
      var provincia = "BN";
      var descrizione =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci. Sed nunc neque, faucibus vel feugiat eu, " +
              "fermentum ornare metus. Etiam volutpat sed lacus eu efficitur. Sed tincidunt mauris id cursus rutrum. Praesent pellentesque ultrices lectus, vel porta felis eleifend sed. Etiam ac molestie eros. ";

      assert(funzioneTest(
              nome: nome,
              cognome: cognome,
              cf: cf,
              numeroTelefono: numeroTelefono,
              indirizzo: indirizzo,
              provincia: provincia,
              cap: cap,
              email: email,
              descrizione: descrizione,
              impegnativa: file) ==
          "Errore: formato indirizzo email non rispettato");
    }));

    test("TC_GPSP.1.1_6", (() {
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(
          name: "impegnativa.pdf",
          size: 5000000,
          bytes: Uint8List.fromList([10, 20, 30])));
      var file = FilePickerResult(files);
      var nome = "Luca";
      var cognome = "Rossi";
      var numeroTelefono = "3345431203";
      var indirizzo = "Via del Campo,2";
      var email = "test@gmail.com";
      var cf = "D02T32I197R";
      var cap = "82019";
      var provincia = "BN";
      var descrizione =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci. Sed nunc neque, faucibus vel feugiat eu, " +
              "fermentum ornare metus. Etiam volutpat sed lacus eu efficitur. Sed tincidunt mauris id cursus rutrum. Praesent pellentesque ultrices lectus, vel porta felis eleifend sed. Etiam ac molestie eros. ";

      assert(funzioneTest(
              nome: nome,
              cognome: cognome,
              cf: cf,
              numeroTelefono: numeroTelefono,
              indirizzo: indirizzo,
              provincia: provincia,
              cap: cap,
              email: email,
              descrizione: descrizione,
              impegnativa: file) ==
          "Errore: formato codice fiscale non rispettato");
    }));

    test("TC_GPSP.1.1_7", (() {
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(
          name: "impegnativa.pdf",
          size: 5000000,
          bytes: Uint8List.fromList([10, 20, 30])));
      var file = FilePickerResult(files);
      var nome = "Luca";
      var cognome = "Rossi";
      var numeroTelefono = "3345431203";
      var indirizzo = "Via del Campo,2";
      var email = "test@gmail.com";
      var cf = "DLCNCL02T32I197R";
      var cap = "82019786T";
      var provincia = "BN";
      var descrizione =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci. Sed nunc neque, faucibus vel feugiat eu, " +
              "fermentum ornare metus. Etiam volutpat sed lacus eu efficitur. Sed tincidunt mauris id cursus rutrum. Praesent pellentesque ultrices lectus, vel porta felis eleifend sed. Etiam ac molestie eros. ";

      assert(funzioneTest(
              nome: nome,
              cognome: cognome,
              cf: cf,
              numeroTelefono: numeroTelefono,
              indirizzo: indirizzo,
              provincia: provincia,
              cap: cap,
              email: email,
              descrizione: descrizione,
              impegnativa: file) ==
          "Errore: formato CAP non rispettato");
    }));

    test("TC_GPSP.1.1_8", (() {
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(
          name: "impegnativa.pdf",
          size: 5000000,
          bytes: Uint8List.fromList([10, 20, 30])));
      var file = FilePickerResult(files);
      var nome = "Luca";
      var cognome = "Rossi";
      var numeroTelefono = "3345431203";
      var indirizzo = "Via del Campo,2";
      var email = "test@gmail.com";
      var cf = "DLCNCL02T32I197R";
      var cap = "82019";
      var provincia = "BNOL4";
      var descrizione =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci. Sed nunc neque, faucibus vel feugiat eu, " +
              "fermentum ornare metus. Etiam volutpat sed lacus eu efficitur. Sed tincidunt mauris id cursus rutrum. Praesent pellentesque ultrices lectus, vel porta felis eleifend sed. Etiam ac molestie eros. ";

      assert(funzioneTest(
              nome: nome,
              cognome: cognome,
              cf: cf,
              numeroTelefono: numeroTelefono,
              indirizzo: indirizzo,
              provincia: provincia,
              cap: cap,
              email: email,
              descrizione: descrizione,
              impegnativa: file) ==
          "Errore: formato provincia non rispettato");
    }));

    test("TC_GPSP.1.1_9", (() {
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(
          name: "impegnativa.pdf",
          size: 5000000,
          bytes: Uint8List.fromList([10, 20, 30])));
      var file = FilePickerResult(files);
      var nome = "Luca";
      var cognome = "Rossi";
      var numeroTelefono = "3345431203";
      var indirizzo = "Via del Campo,2";
      var email = "test@gmail.com";
      var cf = "DLCNCL02T32I197R";
      var cap = "82019";
      var provincia = "BN";
      var descrizione =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci. Sed nunc neque, faucibus vel feugiat eu, fermentum ornare metus. Etiam volutpat sed lacus eu efficitur. Sed tincidunt mauris id cursus rutrum. Praesent pellentesque ultrices lectus, vel porta felis eleifend sed. Etiam ac molestie eros. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci. Sed nunc neque, faucibus vel feugiat eu, fermentum ornare metus. Etiam volutpat sed lacus eu efficitur. Sed tincidunt mauris id cursus rutrum. Praesent pellentesque ultrices lectus, vel porta felis eleifend sed. Etiam ac molestie eros. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci. Sed nunc neque, faucibus vel feugiat eu, fermentum ornare metus. Etiam volutpat sed lacus eu efficitur. Sed tincidunt mauris id cursus rutrum. Praesent pellentesque ultrices lectus, vel porta felis eleifend sed. Etiam ac molestie eros. ";

      assert(funzioneTest(
              nome: nome,
              cognome: cognome,
              cf: cf,
              numeroTelefono: numeroTelefono,
              indirizzo: indirizzo,
              provincia: provincia,
              cap: cap,
              email: email,
              descrizione: descrizione,
              impegnativa: file) ==
          "Errore: lunghezza descrizione non valida");
    }));

    test("TC_GPSP.1.1_10", (() {
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(
          name: "impegnativa.pdf",
          size: 50000000,
          bytes: Uint8List.fromList([10, 20, 30])));
      var file = FilePickerResult(files);
      var nome = "Luca";
      var cognome = "Rossi";
      var numeroTelefono = "3345431203";
      var indirizzo = "Via del Campo,2";
      var email = "test@gmail.com";
      var cf = "DLCNCL02T32I197R";
      var cap = "82019";
      var provincia = "BN";
      var descrizione =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci. Sed nunc neque, faucibus vel feugiat eu, " +
              "fermentum ornare metus. Etiam volutpat sed lacus eu efficitur. Sed tincidunt mauris id cursus rutrum. Praesent pellentesque ultrices lectus, vel porta felis eleifend sed. Etiam ac molestie eros. ";

      assert(funzioneTest(
              nome: nome,
              cognome: cognome,
              cf: cf,
              numeroTelefono: numeroTelefono,
              indirizzo: indirizzo,
              provincia: provincia,
              cap: cap,
              email: email,
              descrizione: descrizione,
              impegnativa: file) ==
          "Errato: dimensione file non valida");
    }));

    test("TC_GPSP.1.1_11", (() {
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(
          name: "impegnativa.jpg",
          size: 5000000,
          bytes: Uint8List.fromList([10, 20, 30])));
      var file = FilePickerResult(files);
      var nome = "Luca";
      var cognome = "Rossi";
      var numeroTelefono = "3345431203";
      var indirizzo = "Via del Campo,2";
      var email = "test@gmail.com";
      var cf = "DLCNCL02T32I197R";
      var cap = "82019";
      var provincia = "BN";
      var descrizione =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci. Sed nunc neque, faucibus vel feugiat eu, " +
              "fermentum ornare metus. Etiam volutpat sed lacus eu efficitur. Sed tincidunt mauris id cursus rutrum. Praesent pellentesque ultrices lectus, vel porta felis eleifend sed. Etiam ac molestie eros. ";

      assert(funzioneTest(
              nome: nome,
              cognome: cognome,
              cf: cf,
              numeroTelefono: numeroTelefono,
              indirizzo: indirizzo,
              provincia: provincia,
              cap: cap,
              email: email,
              descrizione: descrizione,
              impegnativa: file) ==
          "Errato: estensione del file non supportata (caricare un file in formato pdf)");
    }));

    test("TC_GPSP.1.1_12", (() {
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(
          name: "impegnativa.pdf",
          size: 5000000,
          bytes: Uint8List.fromList([10, 20, 30])));
      var file = FilePickerResult(files);
      var nome = "Luca";
      var cognome = "Rossi";
      var numeroTelefono = "3345431203";
      var indirizzo = "Via del Campo,2";
      var email = "test@gmail.com";
      var cf = "DLCNCL02T32I197R";
      var cap = "82019";
      var provincia = "BN";
      var descrizione =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci. Sed nunc neque, faucibus vel feugiat eu, " +
              "fermentum ornare metus. Etiam volutpat sed lacus eu efficitur. Sed tincidunt mauris id cursus rutrum. Praesent pellentesque ultrices lectus, vel porta felis eleifend sed. Etiam ac molestie eros. ";

      assert(funzioneTest(
              nome: nome,
              cognome: cognome,
              cf: cf,
              numeroTelefono: numeroTelefono,
              indirizzo: indirizzo,
              provincia: provincia,
              cap: cap,
              email: email,
              descrizione: descrizione,
              impegnativa: file) ==
          "true");
    }));
  });
}
