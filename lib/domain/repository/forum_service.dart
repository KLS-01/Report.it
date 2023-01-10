import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:report_it/data/Models/forum_dao.dart';
import 'package:report_it/domain/entity/discussione_entity.dart';
import 'package:report_it/domain/entity/super_utente.dart';
import 'package:report_it/domain/repository/authentication_service.dart';

class ForumService {
  static Future<List<Discussione?>>? _discussioni_all;
  final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<List<Discussione?>?> PrendiTutte() async {
    if (_discussioni_all == null) {
      var list = ForumDao.RetrieveAllForum().then((value) {
        return value;
      });
      _discussioni_all = list;
      return _discussioni_all;
    } else {
      return _discussioni_all;
    }
  }

  Future<List<Discussione?>?> Prendiutente() async {
    final User? user = auth.currentUser;
    if (_discussioni_all == null) {
      PrendiTutte();
    }

    var UtenteDiscussioni = _discussioni_all!.then((value) =>
        value.where((element) => element!.idCreatore == user!.uid).toList());

    return UtenteDiscussioni;
  }

  void AggiungiDiscussione(String titolo, String testo, String categoria) {
    final User? user = auth.currentUser;

    Discussione d = Discussione(
        categoria, DateTime.now(), user!.uid, 0, testo, titolo, "Aperta");

    ForumDao.AggiungiDiscussione(d);
  }

  void AggiornaLista() {
    var list = ForumDao.RetrieveAllForum().then((value) {
      return value;
    });
    _discussioni_all = list;
  }

  void EliminaDiscussione(String? id) {
    ForumDao.cancellaDiscussione(id!);
  }

  void ChiudiDiscussione(String? id) {
    ForumDao.CambiaStato(id, "chiusa");
  }
}
