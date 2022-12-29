import 'package:firebase_auth/firebase_auth.dart';
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
      await auth.signInWithEmailAndPassword(email: email, password: password);
      //TODO: INVOCA FUNZIONE CHE CONTROLLA CON QUERY SUL DB
      return "Signed in with success"; //   return auth.currentUser!.uid.toString();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
