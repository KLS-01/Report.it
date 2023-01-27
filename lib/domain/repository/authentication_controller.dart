import 'package:firebase_auth/firebase_auth.dart';
import 'package:report_it/data/models/AutenticazioneDAO.dart';
import 'package:report_it/domain/entity/entity_GA/spid_entity.dart';
import '../entity/entity_GA/operatoreCUP_entity.dart';
import '../entity/entity_GA/super_utente.dart';
import '../entity/entity_GA/tipo_utente.dart';
import '../entity/entity_GA/uffPolGiud_entity.dart';
import '../entity/entity_GA/utente_entity.dart';

class AuthenticationService {
  final FirebaseAuth auth;

  AuthenticationService(this.auth);

  Stream<User?> get authStateChanges => auth.idTokenChanges();

  Future<void> signOut() async {
    await auth.signOut();
  }

//metodo che converte un FirebaseUser ad un SuperUtente
  Future<SuperUtente?> superUtenteFromFirebaseUser(User? user) async {
    if (user == null) {
      return null;
    } else {
      Utente? ut = await AutenticazioneDAO().RetrieveUtenteByID(user.uid);
      UffPolGiud? uff =
          await AutenticazioneDAO().RetrieveUffPolGiudByID(user.uid);
      OperatoreCUP? op = await AutenticazioneDAO().RetrieveCUPByID(user.uid);
      if (ut != null) {
        return SuperUtente(user.uid, TipoUtente.Utente);
      } else if (uff != null) {
        print("sei un uff");
        return SuperUtente(user.uid, TipoUtente.UffPolGiud,
            cap: uff.capCaserma,
            citta: uff.cittaCaserma,
            indirizzo: uff.indirizzo,
            provincia: uff.provincia);
      } else if (op != null) {
        print("sei un op");
        return SuperUtente(user.uid, TipoUtente.OperatoreCup,
            cap: op.capASL,
            citta: op.cittaASL,
            indirizzo: op.indirizzoASL,
            provincia: op.provinciaASL);
      }
    }
  }

  Stream<SuperUtente?> get superUtenteStream {
    return auth.authStateChanges().asyncMap(superUtenteFromFirebaseUser);
  }

  Future<String?> signIn(
      {required String email,
      required String password,
      required String userType}) async {
    try {
      if (userType == "SPID") {
        LoginSPID(email, password);
      } else {
        try {
          var u = await AutenticazioneDAO().RetrieveSPIDByEmail(email);

          if (u != null) {
            return 'invalid-email';
          }
        } catch (e) {
          print(e);
          if (e.toString() == "Bad state: No element") {
          } else {
            return "invalid-email";
          }
        }
      }

      await auth.signInWithEmailAndPassword(email: email, password: password);
      print('Signed in with success');
      return "logged-success";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.code;
    }
  }

  Future<SPID?> getSpid(String? id) {
    return AutenticazioneDAO().RetrieveSPIDByID(id!);
  }

  Future<String?> LoginSPID(String email, String password) async {
    try {
      var u = await AutenticazioneDAO().RetrieveSPIDByEmail(email);

      if (u!.password != password) {
        print("password sbagliata");

        return 'wrong-password';
      }
    } catch (e) {
      return 'invalid-email';
    }
  }
}
