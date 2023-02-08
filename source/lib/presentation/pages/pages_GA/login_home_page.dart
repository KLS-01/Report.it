import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:report_it/presentation/pages/pages_GA/login_user_page.dart';
import 'package:report_it/presentation/widget/styles.dart';

import '../../../application/repository/authentication_controller.dart';
import 'authentication_wrapper.dart';
import '../navigation_animations.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String userSPID = 'SPID';

    late SnackBar snackBar;
    late String loginOutcome;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ThemeText.theme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 19),
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 50),
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
                      BorderRadius.only(topLeft: Radius.circular(100)),
                  color: Color.fromRGBO(219, 29, 69, 1),
                ),
                child: Stack(
                  children: [
                    // Hero(
                    //   tag: 'redContainer',
                    //   child:
                    // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Sei un cittadino?",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(20),
                              minimumSize: const Size(double.infinity, 20),
                              backgroundColor:
                                  const Color.fromRGBO(0, 102, 204, 1),
                              elevation: 2,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/separator.png',
                              scale: 15,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "altrimenti",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Image.asset('assets/images/separator.png',
                                scale: 15),
                          ],
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                // height: MediaQuery.of(context).size.height * 0.8
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
                                    const EdgeInsets.symmetric(vertical: 30),
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
