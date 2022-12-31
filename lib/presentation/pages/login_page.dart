import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(255, 254, 248, 1),
      body: Center(
        // child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/logo.png',
                  scale: 1.5,
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(100)),
                        color: Color.fromRGBO(219, 29, 69, 1),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print('Mammt');
                            },
                            child: const Text('Entra con SPID'),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                filled: true,
                                fillColor: Color.fromRGBO(255, 254, 248, 1),
                                hintText: 'Inserisci e-mail',
                                labelText: 'E-mail',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                filled: true,
                                fillColor: Color.fromRGBO(255, 254, 248, 1),
                                hintText: 'Inserisci password',
                                labelText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
