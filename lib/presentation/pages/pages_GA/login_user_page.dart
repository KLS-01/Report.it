import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/presentation/pages/pages_GA/authentication_wrapper.dart';

import '../../../domain/repository/authentication_controller.dart';

// ignore: must_be_immutable
class LoginWorker extends StatefulWidget {
  late String userType;

  LoginWorker({required String this.userType});

  @override
  State<LoginWorker> createState() => _LoginWorkerState();
}

class _LoginWorkerState extends State<LoginWorker> {
  //Global key
  final _formKey = GlobalKey<FormState>();

  String error = '';
  //Form field
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    late SnackBar snackBar;
    late String loginOutcome;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Color.fromRGBO(219, 29, 69, 1)),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(255, 254, 248, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 50),
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/images/C11_Logo-png.png',
                    scale: 1.8,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(100)),
                  color: Color.fromRGBO(219, 29, 69, 1),
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Image.asset(
                          'assets/images/spid_banner.png',
                          scale: 6,
                        ),
                        const SizedBox(height: 15),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                margin:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    iconColor: Colors.red,
                                    focusColor: Colors.red,
                                    filled: true,
                                    fillColor: Color.fromRGBO(255, 254, 248, 1),
                                    hintText: 'Inserisci l\'e-mail',
                                    labelText: 'E-mail',
                                    errorStyle: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 15),
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Per favore, inserisci l\'email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextFormField(
                                  obscureText: true,
                                  controller: passwordController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.lock),
                                    iconColor: Colors.red,
                                    focusColor: Colors.red,
                                    filled: true,
                                    fillColor: Color.fromRGBO(255, 254, 248, 1),
                                    hintText: 'Inserisci la password',
                                    labelText: 'Password',
                                    errorStyle: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 15),
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Per favore, inserisci la password';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 40),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: Colors.white,
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        snackBar = const SnackBar(
                                          content:
                                              Text('Validazione in corso...'),
                                        );
                                        ScaffoldMessenger.of(
                                                _formKey.currentContext!)
                                            .showSnackBar(snackBar);

                                        ///'loginOutcome' makes possible to choose the right 'feedback message' to display for the user
                                        loginOutcome = (await context
                                            .read<AuthenticationService>()
                                            .signIn(
                                                email:
                                                    emailController.text.trim(),
                                                password: passwordController
                                                    .text
                                                    .trim(),
                                                userType: 'SPID'))!;

                                        ///alertMessage, thanks to this switch construct, takes the proper value
                                        String alertMessage = "";

                                        switch (loginOutcome) {

                                          ///feedback code created by KLS-01 for notifying and moving to the proper page
                                          case 'logged-success':
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AuthenticationWrapper(),
                                                ));
                                            break;

                                          ///error code from FirebaseAuthException
                                          case 'wrong-password':
                                            alertMessage = 'Password errata';
                                            break;

                                          ///error code from FirebaseAuthException
                                          case 'user-disabled':
                                            alertMessage =
                                                'L\'account a cui è associata questa email è stato disabilitato';
                                            break;

                                          ///error code from FirebaseAuthException
                                          case 'invalid-email':
                                            alertMessage =
                                                'L\'indirizzo email inserito non è valido';
                                            break;

                                          default:
                                            alertMessage =
                                                'Errore nell\'accesso';
                                            break;
                                        }
                                        print('Test: $loginOutcome');

                                        ///The snackbar will display the message to alert the user (ex. for an error, ...)
                                        snackBar = SnackBar(
                                          content: Text(alertMessage),
                                        );
                                        ScaffoldMessenger.of(
                                                _formKey.currentContext!)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                                    child: const Text(
                                      "Accedi",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
