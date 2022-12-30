import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/repository/authentication_service.dart';
import 'authentication_wrapper.dart';

class LoginWorker extends StatefulWidget {
  late String workerType;

  LoginWorker({required String this.workerType});

  @override
  State<LoginWorker> createState() => _LoginWorkerState();
}

class _LoginWorkerState extends State<LoginWorker> {
  //Global key
  final _formKey = GlobalKey<FormState>();

  String error = '';
  bool loading = false;
  //Form field
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    late SnackBar snackBar;
    late String loginOutcome;

    return MaterialApp(
      title: "Report.it",
      debugShowCheckedModeBanner: false,
      home: ScaffoldMessenger(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Login ${widget.workerType}"),
            backgroundColor: Colors.red,
            leading: GestureDetector(
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    child: Text(
                      "Accesso ${widget.workerType}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.red,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        iconColor: Colors.red,
                        focusColor: Colors.red,
                        labelText: "Email",
                        hintText: "Inserisci email",
                        fillColor: Colors.red,
                        icon: Icon(Icons.email)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Per favore, inserisci la mail';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: "Password",
                      hintText: "Inserisci password",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Per favore, inserisci la password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FloatingActionButton.extended(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // setState(() => loading = true);
                        snackBar = const SnackBar(
                          content: Text('Validazione in corso...'),
                        );
                        ScaffoldMessenger.of(_formKey
                                .currentContext!) //TODO: controlla che cos'e' il '!', credo significhi "fra traquillo, lo so che puo' essere null", sticaxxi
                            .showSnackBar(snackBar);

                        // snackBar = SnackBar(
                        //   content: Text(
                        loginOutcome =
                            (await context.read<AuthenticationService>().signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  userType: widget.workerType,
                                ))!;

                        String alertMessage = "";

                        switch (loginOutcome) {
                          case 'logged-success':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AuthenticationWrapper(),
                              ),
                            );
                            break;

                          case 'invalid-email':
                            alertMessage =
                                'L\'indirizzo email inserito non è valido';
                            break;
                          case 'user-disabled':
                            alertMessage =
                                'L\'account a cui è associata questa email è stato disabilitato';
                            break;
                          case 'user-not-found':
                            alertMessage =
                                'L\'email inserita non è associata ad alcun account';
                            break;
                          case 'wrong-password':
                            alertMessage = 'Password errata';
                            break;
                          default:
                            alertMessage = 'Errore nell\'accesso';
                            break;
                        }
                        print('Test: $loginOutcome');

                        snackBar = SnackBar(
                          content: Text(alertMessage),
                        );

                        ScaffoldMessenger.of(_formKey.currentContext!)
                            .showSnackBar(snackBar);

                        //   ),
                        // );

                        // setState(() => loading = false);

                        // ScaffoldMessenger.of(_formKey.currentContext!)
                        //     .showSnackBar(snackBar);
                      }
                    },
                    label: const Text(
                      "Accedi",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
