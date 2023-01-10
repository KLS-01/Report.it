import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:report_it/domain/entity/stato_denuncia.dart';
import 'package:report_it/domain/entity/tipo_utente.dart';
import 'package:report_it/domain/entity/uffPolGiud_entity.dart';

import "../../data/models/denuncia_dao.dart";
import '../entity/denuncia_entity.dart';
import "../../data/models/autenticazioneDAO.dart";
import '../entity/super_utente.dart';
import "../entity/utente_entity.dart";
import "authentication_service.dart";

class DenunciaController {
  DenunciaDao denunciaDao = DenunciaDao();

  final FirebaseAuth auth = FirebaseAuth.instance;


  Future<List<Denuncia>> visualizzaStoricoDenunceByUtente(SuperUtente? utente) async {

    if (utente == null) {
      print("NON SEI LOGGATO");
    } else {
      if(utente.tipo==TipoUtente.Utente){
        return await denunciaDao.retrieveByUtente(utente.id);
      }
      else{
        print("sto chiamando il dao per fare il retriveByUff");
        return await denunciaDao.retrieveByUff(utente.id);
      }
    }
    return Future.error(StackTrace);
  }

  Future<List<Denuncia>> filtraDenunciaByStato(Future<List<Denuncia>> denunce, StatoDenuncia stato){
          return denunce.then((value){
            return value.where((element) => element.statoDenuncia== stato).toList();
          });
  }



  Future<List<Denuncia>> visualizzaDenunceByStato(StatoDenuncia stato){
    return denunciaDao.retrieveByStato(stato);
  }

  Future<Denuncia?> visualizzaDenunciaById(String idDenuncia, SuperUtente utente) async {
    //bisogna fare il controllo se è un uffPolGiud che ha accettato questa denuncia nel caso sia accettata
    final User? user = auth.currentUser;
    if (user == null) {
      print("NON SEI LOGGATO");
    } else {
      Denuncia? d = await denunciaDao.retrieveById(idDenuncia);
      if (d == null) {
        return null;
      } else if (d.idUtente != user.uid) {
        return null;
      } else {
        return d;
      }
    }
    return Future.error(StackTrace);
  }

  Future<String?> addDenunciaControl(
      {required nomeDenunciante,
      required cognomeDenunciante,
      required indirizzoDenunciante,
      required capDenunciante,
      required provinciaDenunciante,
      required cellulareDenunciante,
      required emailDenunciante,
      required tipoDocDenunciante,
      required numeroDocDenunciante,
      required scadenzaDocDenunciante,
      required categoriaDenuncia,
      required nomeVittima,
      required denunciato,
      required descrizione,
      required cognomeVittima,
      required bool consenso,
      required bool alreadyFilled}) async {
    Timestamp today = Timestamp.now();

    final User? user = auth.currentUser;
    if (user == null) {
      print("Non loggato");
    } else {
      print("Ok");
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
        tipoDocDenunciante: tipoDocDenunciante,
        numeroDocDenunciante: numeroDocDenunciante,
        scadenzaDocDenunciante: scadenzaDocDenunciante,
        categoriaDenuncia: categoriaDenuncia,
        nomeVittima: nomeVittima,
        denunciato: denunciato,
        descrizione: descrizione,
        cognomeVittima: cognomeVittima,
        alreadyFiled: alreadyFilled,
        consenso: consenso,
        cognomeUff: null,
        coordCaserma: null,
        dataDenuncia: today,
        idUff: null,
        idUtente: user!.uid,
        nomeCaserma: null,
        nomeUff: null,
        statoDenuncia: StatoDenuncia.NonInCarico);

    String? result;
    DenunciaDao.addDenuncia(denuncia).then((DocumentReference<Object?> id) {
      denuncia.setId = id.id;
      DenunciaDao.updateId(denuncia.getId);
      result = denuncia.getId;
    });
    return await result;
  }

  Future<bool> accettaDenuncia(String idDenuncia, SuperUtente utente) async {
    //controllo se l'utente è un UffPolGiud

    if (utente.tipo != TipoUtente.UffPolGiud) {
      return false;
    } else {
      Denuncia? d = await denunciaDao.retrieveById(idDenuncia);
      if (d == null) {
        return false;
      } else {
        UffPolGiud? uff = await RetrieveUffPolGiudByID(utente.id);
        if (uff == null) {
          return false;
        } else {
          denunciaDao.accettaDenuncia(idDenuncia, uff.coordinate, uff.id,
              uff.nomeCaserma, uff.nome, uff.cognome);
          return true;
        }
      }
    }
  }
}
