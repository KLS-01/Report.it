import 'package:firebase_auth/firebase_auth.dart';
import 'package:report_it/data/models/AutenticazioneDAO.dart';
import 'package:report_it/domain/entity/operatoreCUP_entity.dart';
import 'package:report_it/domain/entity/spid_entity.dart';
import 'package:report_it/domain/entity/super_utente.dart';
import 'package:report_it/domain/entity/tipo_utente.dart';
import 'package:report_it/domain/entity/utente_entity.dart';

import '../entity/uffPolGiud_entity.dart';


class AuthenticationService {
  final FirebaseAuth auth;

  AuthenticationService(this.auth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User?> get authStateChanges => auth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await auth.signOut();
  }

//metodo che converte un FirebaseUser ad un SuperUtente
  Future<SuperUtente?> superUtenteFromFirebaseUser(User? user)async{
    if(user==null){
      return null;
    }
    else{
      Utente? ut= await RetrieveUtenteByID(user.uid);
      UffPolGiud? uff=await RetrieveUffPolGiudByID(user.uid);
      if(ut != null) {
        return SuperUtente(
            user.uid, TipoUtente.Utente);
      }else if(uff != null) {
        print("sei un uff");
        return SuperUtente(
            user.uid, TipoUtente.UffPolGiud);
      }else{
        print("sei un op");
        return SuperUtente(
            user.uid, TipoUtente.OperatoreCup);
      }
    }
  }


  Stream<SuperUtente?> get superUtenteStream {
      return auth.authStateChanges().asyncMap(superUtenteFromFirebaseUser);
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String?> signIn(
      {required String email,
      required String password,
      required String userType})
  async
  {
    try {
      if (userType == "SPID") {
        try {
          var u = await RetrieveSPIDByEmail(email);

          if (u!.password != password) {
            print("password sbagliata"); //only for testing TODO: Remove

            ///One of the [FirebaseAuthException] error code that may be throwed
            ///(handled in login pages)
            return 'wrong-password';
          }
        } catch (e) {
          return 'invalid-email';
        }
      } else {
        try {
          var u = await RetrieveSPIDByEmail(email);

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

      ///An 'outcome' code 'self-made' that, by working along with the other
      ///[FirebaseAuthException] error code, makes possible to handle also this
      ///outcome (possibly by redirectiong to the homepage after bein logged-in)

    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.code;
    }
  }



}
