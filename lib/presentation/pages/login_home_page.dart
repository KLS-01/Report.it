import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:report_it/presentation/pages/login_user_page.dart';

import '../../domain/repository/authentication_service.dart';
import 'authentication_wrapper.dart';
import 'navigation_animations.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    String userWorker = 'WRK';
    String userSPID = 'SPID';

    final TextEditingController passwordController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    late SnackBar snackBar;
    late String loginOutcome;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(255, 254, 248, 1),
      body: SafeArea(
        child: Center(
          // child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 19),
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 50),
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/images/logo.png',
                    scale: 1.8,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Stack(
                  children: [
                    // Hero(
                    //   tag: 'redContainer',
                    //   child:
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(100)),
                        color: Color.fromRGBO(219, 29, 69, 1),
                      ),
                    ),
                    // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(20),
                              minimumSize: const Size(double.infinity, 20),
                              backgroundColor:
                                  const Color.fromRGBO(0, 102, 204, 1),
                              elevation: 15,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(createRouteTo(
                                  LoginWorker(userType: userSPID)));
                            },
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SvgPicture.asset(
                                    'assets/images/spid-ico.svg',
                                    height: 22,
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Entra con SPID',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            // margin: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                            // child: ElevatedButton(
                            //   style: ElevatedButton.styleFrom(
                            //     padding: const EdgeInsets.all(20),
                            //     minimumSize: const Size(double.infinity, 20),
                            //     backgroundColor: Colors.green,
                            //     elevation: 15,
                            //   ),
                            //   onPressed: () {
                            //     Navigator.of(context).push(createRouteTo(
                            //         LoginWorker(userType: userWorker)));
                            //   },
                            //   child: const Text(
                            //     'Accesso FFOO o CUP',
                            //     style: TextStyle(
                            //       fontSize: 20,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                            children: [
                              Container(
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
                                margin:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
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
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: Colors.green,
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        // setState(() => loading = true);
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
                                                userType: 'WRK'))!;

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
                                        print(
                                            'Test: $loginOutcome'); //TODO: only for tes. Action: Remove.

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
                                          fontWeight: FontWeight.bold),
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
