import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/repository/login_controller.dart';
import '../../domain/repository/authentication_service.dart';
import 'authentication_wrapper.dart';

class LoginWorker extends StatefulWidget {
  late String workerType;

  LoginWorker({required String this.workerType});

  @override
  State<LoginWorker> createState() => _LoginWorkerState();
}

class _LoginWorkerState extends State<LoginWorker> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //Global key
  final keys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
            key: keys,
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
                    onPressed: () {
                      if (keys.currentState!.validate()) {
                        const snackBar = SnackBar(
                          content: Text('Validazione in corso...'),
                        );
                        ScaffoldMessenger.of(keys
                                .currentContext!) //TODO: controlla che cos'e' il '!', credo significhi "fra traquillo, lo so che puo' essere null", sticaxxi
                            .showSnackBar(snackBar);
                      }
                      context.read<AuthenticationService>().signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            userType: widget.workerType,
                          ) as String;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthenticationWrapper(),
                        ),
                      );
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
