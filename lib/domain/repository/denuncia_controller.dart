import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:report_it/domain/entity/stato_denuncia.dart';
import 'package:report_it/domain/entity/uffPolGiud_entity.dart';

import "../../data/models/denuncia_dao.dart";
import '../entity/denuncia_entity.dart';
import "../../data/models/autenticazioneDAO.dart";
import "../entity/utente_entity.dart";

class DenunciaController {
  DenunciaDao denunciaDao = DenunciaDao();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<Denuncia>> visualizzaDenunceByUtente() async {
      final User? user = auth.currentUser;
      if (user == null) {
        print("NON SEI LOGGATO biscottooo");
      } else {
        return await denunciaDao.retrieveByUtente(user.uid);
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

  Future<UffPolGiud?> controlloUffPolGiud() async{
    String? user= auth.currentUser?.uid;
    if(user==null){
      return null;
    }
    else{
      UffPolGiud? u= await RetrieveUffPolGiudByID(user!);
      if(u==null){
        return null;
      }
      else{
        return u;
      }
    }
  }


  Future<bool> accettaDenuncia(String idDenuncia) async {
    //controllo se l'utente è un UffPolGiud
    UffPolGiud? uff= await controlloUffPolGiud();
    if(uff==null){
      return false;
    }
    else{
      Denuncia? d= await denunciaDao.retrieveById(idDenuncia);
      if(d == null){
        return false;
      }
      else{
        denunciaDao.accettaDenuncia(idDenuncia, uff.coordinate, uff.id, uff.nomeCaserma, uff.nome, uff.cognome);
        return true;
      }
    }
  }
}
