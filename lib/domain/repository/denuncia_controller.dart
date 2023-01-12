import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:report_it/domain/entity/entity_GD/stato_denuncia.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/domain/entity/entity_GA/uffPolGiud_entity.dart';

import "../../data/models/denuncia_dao.dart";
import '../entity/entity_GD/denuncia_entity.dart';
import "../../data/models/autenticazioneDAO.dart";
import '../entity/entity_GA/super_utente.dart';
import '../entity/entity_GA/utente_entity.dart';
import "authentication_controller.dart";

class DenunciaController {
  DenunciaDao denunciaDao = DenunciaDao();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Denuncia jsonToDenuncia(QueryDocumentSnapshot<Map<String, dynamic>> json){
    return Denuncia.fromJson(json.data());
  }

  Denuncia jsonToDenunciaDettagli(Map<String, dynamic> json){
    return Denuncia.fromJson(json);
  }

  Stream<QuerySnapshot<Map<String,dynamic>>> generaStreamDenunciaByUtente(SuperUtente utente){
    return DenunciaDao().generaStreamDenunceByUtente(utente);
  }

  Stream<QuerySnapshot<Map<String,dynamic>>> generaStreamDenunciaByStato(StatoDenuncia stato){
    return DenunciaDao().generaStreamDenunceByStato(stato);
  }

  Stream<DocumentSnapshot<Map<String,dynamic>>> generaStreamDenunciaById(String id){
    return DenunciaDao().generaStreamDenunceById(id);
  }

  Future<List<Denuncia>> visualizzaDenunceByStato(StatoDenuncia stato) {
    return denunciaDao.retrieveByStato(stato);
  }

  Future<Denuncia?> visualizzaDenunciaById(String idDenuncia, SuperUtente utente) async {
      Denuncia? d = await denunciaDao.retrieveById(idDenuncia);
      if(d==null){
        return d;
      }else if(utente.tipo==TipoUtente.Utente){
        return d;
      }else{
        if(d.statoDenuncia==StatoDenuncia.NonInCarico){
          return d;
        }else if(d.idUff==utente.id){
          return d;
        }else{
          return null;
        }
      }
  }

  Future<String?> addDenunciaControl({required nomeDenunciante,
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

  Future<bool> accettaDenuncia(Denuncia denuncia, SuperUtente utente) async {
    //controllo se l'utente è un UffPolGiud
    //debug per prova stream
    DenunciaDao().generaStreamDenunceByUtente(utente);
    if (utente.tipo != TipoUtente.UffPolGiud) {
      return false;
    } else {
      UffPolGiud? uff = await RetrieveUffPolGiudByID(utente.id);
      if (uff == null) {
        return false;
      } else {
        denunciaDao.accettaDenuncia(denuncia.id!, uff.coordinate, uff.id,
            uff.nomeCaserma, uff.nome, uff.cognome);
        return true;
      }
    }
  }

  Future<void> chiudiDenuncia(Denuncia denuncia, SuperUtente utente)async{
    if (utente.tipo != TipoUtente.UffPolGiud) {
      return;
    } else {

        if (denuncia.idUff != utente.id) {
          return;
        } else {
          return await DenunciaDao().updateAttribute(denuncia.id!,"Stato", StatoDenuncia.NonInCarico.name.toString());
        }
    }
  }

}
