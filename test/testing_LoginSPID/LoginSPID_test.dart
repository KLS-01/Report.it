import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:report_it/data/models/AutenticazioneDAO.dart';
import 'package:report_it/domain/entity/entity_GA/spid_entity.dart';

import 'LoginSPID_test.mocks.dart';

@GenerateMocks([
  AutenticazioneDAO
], customMocks: [
  MockSpec<AutenticazioneDAO>(as: #MockAutenticazioneDAORelaxed),
])
void main() {
  late AutenticazioneDAO daoA;

  setUp(() {
    daoA = MockAutenticazioneDAO();
  });

  funzionetest(String email, String password) async {
    final regexEmail = RegExp(r"^[A-z0-9\.\+_-]+@[A-z0-9\._-]+\.[A-z]{2,6}$");
    if (!regexEmail.hasMatch(email)) {
      return "Il formato della e-mail non è stato rispettato";
    }
    final regexPassword = RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&\/]{8,}$");

    when(daoA.RetrieveSPIDByEmail(email))
        .thenAnswer((realInvocation) => Future((() {
              if (email == "r.ferraris104@studenti.unisa.it") {
                return null;
              } else if (email == "r.ferraris1@studenti.unisa.it" &&
                  (password == "PassErrata12*/" || password == "PassErrata")) {
                return SPID(
                    "cf",
                    "nome",
                    "cognome",
                    "luogoNascita",
                    DateTime.now(),
                    "sesso",
                    "tipoDocumento",
                    "numeroDocumento",
                    "domicilioFisico",
                    "provinciaNascita",
                    DateTime.now(),
                    "numCellulare",
                    email,
                    "password");
              } else if (email == "r.ferraris1@studenti.unisa.it" &&
                  password == "PassCorretta12*/") {
                return SPID(
                    "cf",
                    "nome",
                    "cognome",
                    "luogoNascita",
                    DateTime.now(),
                    "sesso",
                    "tipoDocumento",
                    "numeroDocumento",
                    "domicilioFisico",
                    "provinciaNascita",
                    DateTime.now(),
                    "numCellulare",
                    email,
                    password);
              }
            })));
    try {
      var u = await daoA.RetrieveSPIDByEmail(email);

      if (u == null) {
        return "L’e-mail non è associata a nessun account";
      }

      if (!regexPassword.hasMatch(password)) {
        return "Il formato della password non è stato rispettato";
      }

      if (u.password != password) {
        return "La password non è corretta";
      }

      return "Corretto";
    } catch (e) {
      return 'invalid-email';
    }
  }

  group("Login_SPID", (() {
    test("TC_1.1_1", (() async {
      String email = "@asd,lololol/.pippo";
      String password = "";

      assert(await funzionetest(email, password).then((value) => value) ==
          "Il formato della e-mail non è stato rispettato");
    }));
    test("TC_1.1_2", (() async {
      String email = "r.ferraris104@studenti.unisa.it";
      String password = "";

      assert(await funzionetest(email, password).then((value) => value) ==
          "L’e-mail non è associata a nessun account");
    }));
    test("TC_1.1_3", (() async {
      String email = "r.ferraris1@studenti.unisa.it";
      String password = "PassErrata";

      assert(await funzionetest(email, password).then((value) => value) ==
          "Il formato della password non è stato rispettato");
    }));
    test("TC_1.1_4", (() async {
      String email = "r.ferraris1@studenti.unisa.it";
      String password = "PassErrata12*/";

      assert(await funzionetest(email, password).then((value) => value) ==
          "La password non è corretta");
    }));
    test("TC_1.1_5", (() async {
      String email = "r.ferraris1@studenti.unisa.it";
      String password = "PassCorretta12*/";

      assert(await funzionetest(email, password).then((value) => value) ==
          "Corretto");
    }));
  }));
}
