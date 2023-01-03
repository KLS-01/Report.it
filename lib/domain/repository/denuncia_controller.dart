import 'package:firebase_auth/firebase_auth.dart';

import "../../data/models/denuncia_dao.dart";
import '../entity/denuncia_entity.dart';
import "../../data/models/autenticazioneDAO.dart";
import "../entity/utente_entity.dart";
class DenunciaController{
  DenunciaDao denunciaDao= DenunciaDao();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<Denuncia>>visualizzaDenunceByUtente()async{

    try {
      final User? user = auth.currentUser;
      if(user==null) {
        print("NON SEI LOGGATO biscottooo");
      }
      else {
        return await denunciaDao.retrieveByUtente(user.uid);
      }
    }
    catch(e){
      print(e);
      rethrow;
    }
    return Future.error(StackTrace);
  }
}