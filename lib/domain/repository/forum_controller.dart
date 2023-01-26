import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:report_it/data/Models/AutenticazioneDAO.dart';
import 'package:report_it/data/Models/forum_dao.dart';
import 'package:report_it/data/models/AutenticazioneDAO.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/domain/entity/entity_GF/discussione_entity.dart';

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

  Future<String> AggiungiDiscussioneUFF(String titolo, String testo,
      [FilePickerResult? file]) async {
    final User? user = auth.currentUser;
    if (titolo.length > 80 || titolo.isEmpty) {
      return "titolo troppo lungo";
    }

    if (testo.length > 400) {
      return "testo troppo lungo";
    }
    var tipo = "UFF";

    if (file != null) {
      if (file.files.first.size > 10485760) {
        return "file troppo grande";
      }

      if (file.files.first.extension != "png" &&
          file.files.first.extension != "jpeg") {
        return "formato file non supportato";
      }
      var c = ForumDao().caricaImmagne(file);

      Discussione d = Discussione(
          DateTime.now(), user!.uid, 0, testo, titolo, "Aperta", [], tipo);
      await c.then((value) {
        d.setpathImmagine(value);
      });
      ForumDao().AggiungiDiscussione(d);
      return "tutto ok";
    } else {
      Discussione d = Discussione(
          DateTime.now(),
          user!.uid,
          0,
          testo,
          titolo,
          "Aperta",
          pathImmagine: "",
          [],
          tipo);
      ForumDao().AggiungiDiscussione(d);
      return "tutto ok";
    }
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
    ForumDao.CambiaStato(id, "Chiusa");
  }

  void CambiaAdapertaDiscussione(String? id) {
    ForumDao.CambiaStato(id, "Aperta");
  }

  Future<int> sostieniDiscusione(String id, String idUtente) {
    return ForumDao.modificaPunteggio(id, 1, idUtente);
  }

  Future<int> desostieniDiscusione(String id, String idUtente) {
    return ForumDao.modificaPunteggio(id, -1, idUtente);
  }

  Future<Commento> aggiungiCommento(String testo, String uid,
      String discussione, SuperUtente? superUtente) async {
    var tipo = "";

    if (superUtente!.tipo == TipoUtente.Utente) {
      tipo = "Utente";
    } else if (superUtente.tipo == TipoUtente.UffPolGiud) {
      tipo = "UFF";
    } else {
      tipo = "CUP";
    }

    var c = Commento(uid, DateTime.now(), testo, tipo);

    if (superUtente.tipo == TipoUtente.OperatoreCup) {
      await AutenticazioneDAO().RetrieveCUPByID(uid).then((value) {
        c.nome = value!.nome;
        c.cognome = value.cognome;
      });
    } else if (superUtente.tipo == TipoUtente.UffPolGiud) {
      await AutenticazioneDAO().RetrieveUffPolGiudByID(uid).then((value) {
        c.nome = value!.nome;
        c.cognome = value.cognome;
      });
    } else {
      await AutenticazioneDAO().RetrieveSPIDByID(uid).then((value) {
        c.nome = value!.nome;
        c.cognome = value.cognome;
      });
    }

    ForumDao.AggiungiCommento(c, discussione);

    return c;
  }

  Future<List<Commento?>> retrieveCommenti(String id) async {
    return await ForumDao.RetrieveAllCommenti(id);
  }

  Future<String> ApriDiscussione(String titolo, String testo,
      [FilePickerResult? file]) async {
    final User? user = auth.currentUser;

    if (titolo.length > 80 || titolo.isEmpty) {
      return "titolo troppo lungo";
    }

    if (testo.length > 400) {
      return "testo troppo lungo";
    }

    var tipo = "Utente";

    if (file != null) {
      if (file.files.first.size > 10485760) {
        return "file troppo grande";
      }

      if (file.files.first.extension != "png" &&
          file.files.first.extension != "jpeg") {
        return "formato file non supportato";
      }
      var c = ForumDao().caricaImmagne(file);

      Discussione d = Discussione(
          DateTime.now(), user!.uid, 0, testo, titolo, "Aperta", [], tipo);
      await c.then((value) {
        d.setpathImmagine(value);
      });
      ForumDao().AggiungiDiscussione(d);
      return "tutto ok";
    } else {
      Discussione d = Discussione(
          DateTime.now(),
          user!.uid,
          0,
          testo,
          titolo,
          "Aperta",
          pathImmagine: "",
          [],
          tipo);
      ForumDao().AggiungiDiscussione(d);
      return "tutto ok";
    }
  }

  Future<String> AggiungiDiscussioneCUP(String titolo, String testo,
      [FilePickerResult? file]) async {
    final User? user = auth.currentUser;

    if (titolo.length > 80 || titolo.isEmpty) {
      return "titolo troppo lungo";
    }

    if (testo.length > 400) {
      return "testo troppo lungo";
    }

    var tipo = "CUP";

    if (file != null) {
      if (file.files.first.size > 10485760) {
        return "file troppo grande";
      }

      if (file.files.first.extension != "png" &&
          file.files.first.extension != "jpeg") {
        return "formato file non supportato";
      }
      var c = ForumDao().caricaImmagne(file);

      Discussione d = Discussione(
          DateTime.now(), user!.uid, 0, testo, titolo, "Aperta", [], tipo);
      await c.then((value) {
        d.setpathImmagine(value);
      });
      ForumDao().AggiungiDiscussione(d);
      return "tutto ok";
    } else {
      Discussione d = Discussione(
          DateTime.now(),
          user!.uid,
          0,
          testo,
          titolo,
          "Aperta",
          pathImmagine: "",
          [],
          tipo);
      ForumDao().AggiungiDiscussione(d);
      return "tutto ok";
    }
  }
}
