import 'package:firebase_auth/firebase_auth.dart';
import 'package:report_it/data/models/AutenticazioneDAO.dart';
import 'package:report_it/domain/repository/login_controller.dart';

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

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String?> signIn(
      {required String email,
      required String password,
      required String userType}) async {
    try {
      if (userType == "SPID") {
        try {
          var u = await RetrieveSPIDByEmail(email);
          if (u.password == password) {
            await auth.signInWithEmailAndPassword(
                email: email, password: password);

            return "Signed in with success";
          } else {
            print("password sbagliata");
          }
        } catch (e) {
          print("utente non trovato");
        }
      }

      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in with success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
