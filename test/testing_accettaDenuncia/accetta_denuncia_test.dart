import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:report_it/data/Models/AutenticazioneDAO.dart';
import 'package:report_it/data/Models/denuncia_dao.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_ufficiale.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/domain/entity/entity_GA/uffPolGiud_entity.dart';
import 'package:report_it/domain/entity/entity_GD/categoria_denuncia.dart';
import 'package:report_it/domain/entity/entity_GD/denuncia_entity.dart';
import 'package:report_it/domain/entity/entity_GD/stato_denuncia.dart';

import 'accetta_denuncia_test.mocks.dart';

@GenerateMocks([
  DenunciaDao,
  AutenticazioneDAO
], customMocks: [
  MockSpec<DenunciaDao>(as: #MockDenunciaDaoRelaxed),
  MockSpec<AutenticazioneDAO>(as: #MockAutenticazioneDAORelaxed),
])
void main() {
  late DenunciaDao daoD;
  late AutenticazioneDAO daoA;

  setUp(() {
    // Create mock object.
    daoD = MockDenunciaDao();
    daoA = MockAutenticazioneDAO();
  });

  funzioneTest(Denuncia denuncia, SuperUtente utente) async {
    if (utente.tipo != TipoUtente.UffPolGiud) {
      return "tipo utente non valido";
    } else {
      when(daoA.RetrieveUffPolGiudByID(utente.id))
          .thenAnswer((realInvocation) => Future((() {
                if (utente.id == "123") {
                  return null;
                } else {
                  return UffPolGiud(
                      utente.id,
                      "nome",
                      "cognome",
                      "Colonnello",
                      TipoUfficiale.guardiaDiFinanza,
                      "email",
                      "password",
                      "nomeCaserma",
                      GeoPoint(1, 2),
                      "capCaserma",
                      "cittaCaserma",
                      "indirizzoCaserma",
                      "provinciaCaserma");
                }
              })));

      UffPolGiud? uff = await daoA.RetrieveUffPolGiudByID(utente.id);

      if (uff == null) {
        return "utente non presente nel db";
      } else {
        when(daoD.accettaDenuncia(denuncia.id!, uff.coordinate, uff.id.trim(),
                uff.nomeCaserma, uff.nome, uff.cognome, uff.tipoUff, uff.grado))
            .thenAnswer((realInvocation) {
          Future((() {
            if (denuncia.id == 'IdNonPresenteSulDB123') {
              return null;
            } else {
              return;
            }
          }));
        });

        if (denuncia.id == 'IdNonPresenteSulDB123') {
          return 'denuncia non presente sul db';
        } else {
          daoD.accettaDenuncia(denuncia.id!, uff.coordinate, uff.id.trim(),
              uff.nomeCaserma, uff.nome, uff.cognome, uff.tipoUff, uff.grado);
          return "Corretto";
        }
      }
    }
  }

  group("accetta_denuncia", (() {
    test("TC_GD.4.1_1", (() async {
      Denuncia? denuncia = Denuncia(
        alreadyFiled: true,
        capDenunciante: 'capDenunciante',
        categoriaDenuncia: CategoriaDenuncia.Etnia,
        cellulareDenunciante: 'cellulareDenunciante',
        cognomeDenunciante: 'cognomeDenunciante',
        cognomeUff: null,
        dataDenuncia: Timestamp.fromDate(DateTime(2022, 1, 26)),
        consenso: true,
        descrizione: 'descrizione',
        cognomeVittima: 'cognomeVittima',
        coordCaserma: null,
        indirizzoCaserma: 'indirizzoCaserma',
        emailDenunciante: 'emailDenunciante',
        denunciato: 'denunciato',
        gradoUff: null,
        id: 'JTVFxVpZTb9pP9FwB2qs',
        idUff: null,
        idUtente: 'MjQfAm3PDdOS3BUFJWkrrGBdHyR2',
        indirizzoDenunciante: 'indirizzoDenunciante',
        nomeCaserma: null,
        nomeUff: null,
        nomeDenunciante: 'nomeDenunciante',
        nomeVittima: 'nomeVittima',
        numeroDocDenunciante: 'numeroDocDenunciante',
        provinciaDenunciante: 'provinciaDenunciante',
        scadenzaDocDenunciante: Timestamp.fromDate(DateTime(2032, 8, 10)),
        statoDenuncia: StatoDenuncia.NonInCarico,
        tipoDocDenunciante: 'tipoDocDenunciante',
        tipoUff: null,
      );
      SuperUtente utente =
          SuperUtente("MjQfAm3PDdOS3BUFJWkrrGBdHyR2", TipoUtente.Utente);

      assert(await funzioneTest(denuncia, utente).then((value) => value) ==
          "tipo utente non valido");
    }));

    test("TC_GD.4.1_2", (() async {
      Denuncia? denuncia = Denuncia(
        alreadyFiled: true,
        capDenunciante: 'capDenunciante',
        categoriaDenuncia: CategoriaDenuncia.Etnia,
        cellulareDenunciante: 'cellulareDenunciante',
        cognomeDenunciante: 'cognomeDenunciante',
        cognomeUff: null,
        dataDenuncia: Timestamp.fromDate(DateTime(2022, 1, 26)),
        consenso: true,
        descrizione: 'descrizione',
        cognomeVittima: 'cognomeVittima',
        coordCaserma: null,
        indirizzoCaserma: 'indirizzoCaserma',
        emailDenunciante: 'emailDenunciante',
        denunciato: 'denunciato',
        gradoUff: null,
        id: 'JTVFxVpZTb9pP9FwB2qs',
        idUff: null,
        idUtente: 'MjQfAm3PDdOS3BUFJWkrrGBdHyR2',
        indirizzoDenunciante: 'indirizzoDenunciante',
        nomeCaserma: null,
        nomeUff: null,
        nomeDenunciante: 'nomeDenunciante',
        nomeVittima: 'nomeVittima',
        numeroDocDenunciante: 'numeroDocDenunciante',
        provinciaDenunciante: 'provinciaDenunciante',
        scadenzaDocDenunciante: Timestamp.fromDate(DateTime(2032, 8, 10)),
        statoDenuncia: StatoDenuncia.NonInCarico,
        tipoDocDenunciante: 'tipoDocDenunciante',
        tipoUff: null,
      );
      SuperUtente utente = SuperUtente("123", TipoUtente.UffPolGiud);

      assert(await funzioneTest(denuncia, utente).then((value) => value) ==
          "utente non presente nel db");
    }));
    test("TC_GD.4.1_3", (() async {
      Denuncia? denuncia = Denuncia(
        alreadyFiled: true,
        capDenunciante: 'capDenunciante',
        categoriaDenuncia: CategoriaDenuncia.Etnia,
        cellulareDenunciante: 'cellulareDenunciante',
        cognomeDenunciante: 'cognomeDenunciante',
        cognomeUff: null,
        dataDenuncia: Timestamp.fromDate(DateTime(2022, 1, 26)),
        consenso: true,
        descrizione: 'descrizione',
        cognomeVittima: 'cognomeVittima',
        coordCaserma: null,
        indirizzoCaserma: 'indirizzoCaserma',
        emailDenunciante: 'emailDenunciante',
        denunciato: 'denunciato',
        gradoUff: null,
        id: 'IdNonPresenteSulDB123',
        idUff: null,
        idUtente: 'MjQfAm3PDdOS3BUFJWkrrGBdHyR2',
        indirizzoDenunciante: 'indirizzoDenunciante',
        nomeCaserma: null,
        nomeUff: null,
        nomeDenunciante: 'nomeDenunciante',
        nomeVittima: 'nomeVittima',
        numeroDocDenunciante: 'numeroDocDenunciante',
        provinciaDenunciante: 'provinciaDenunciante',
        scadenzaDocDenunciante: Timestamp.fromDate(DateTime(2032, 8, 10)),
        statoDenuncia: StatoDenuncia.NonInCarico,
        tipoDocDenunciante: 'tipoDocDenunciante',
        tipoUff: null,
      );
      SuperUtente utente =
          SuperUtente("1PZNxmcGrWVN2ezktgyKFVRWdBS2", TipoUtente.UffPolGiud);
      assert(await funzioneTest(denuncia, utente).then((value) {
            return value;
          }) ==
          'denuncia non presente sul db');
    }));

    test("TC_GD.4.1_4", (() async {
      Denuncia? denuncia = Denuncia(
        alreadyFiled: true,
        capDenunciante: 'capDenunciante',
        categoriaDenuncia: CategoriaDenuncia.Etnia,
        cellulareDenunciante: 'cellulareDenunciante',
        cognomeDenunciante: 'cognomeDenunciante',
        cognomeUff: null,
        dataDenuncia: Timestamp.fromDate(DateTime(2022, 1, 26)),
        consenso: true,
        descrizione: 'descrizione',
        cognomeVittima: 'cognomeVittima',
        coordCaserma: null,
        indirizzoCaserma: 'indirizzoCaserma',
        emailDenunciante: 'emailDenunciante',
        denunciato: 'denunciato',
        gradoUff: null,
        id: 'JTVFxVpZTb9pP9FwB2qs',
        idUff: null,
        idUtente: 'MjQfAm3PDdOS3BUFJWkrrGBdHyR2',
        indirizzoDenunciante: 'indirizzoDenunciante',
        nomeCaserma: null,
        nomeUff: null,
        nomeDenunciante: 'nomeDenunciante',
        nomeVittima: 'nomeVittima',
        numeroDocDenunciante: 'numeroDocDenunciante',
        provinciaDenunciante: 'provinciaDenunciante',
        scadenzaDocDenunciante: Timestamp.fromDate(DateTime(2032, 8, 10)),
        statoDenuncia: StatoDenuncia.NonInCarico,
        tipoDocDenunciante: 'tipoDocDenunciante',
        tipoUff: null,
      );
      SuperUtente utente =
          SuperUtente("1PZNxmcGrWVN2ezktgyKFVRWdBS2", TipoUtente.UffPolGiud);

      assert(await funzioneTest(denuncia, utente).then((value) => value) ==
          "Corretto");
    }));
  }));
}
