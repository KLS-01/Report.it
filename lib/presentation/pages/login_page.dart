import 'package:flutter/material.dart';
import 'package:report_it/presentation/pages/login_spid.dart';

class LoginUser extends StatelessWidget {
  const LoginUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(255, 254, 248, 1),
      body: SafeArea(
        child: Center(
          // child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: EdgeInsets.fromLTRB(0, 100, 0, 50),
                  child: Image.asset(
                    'assets/logo.png',
                    scale: 1.8,
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
                            Container(
                              margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(20),
                                  minimumSize: Size(double.infinity, 20),
                                  elevation: 15,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => LoginSpid())));
                                },
                                child: const Text('Entra con SPID'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(20),
                                  minimumSize: Size(double.infinity, 20),
                                  backgroundColor: Colors.green,
                                  elevation: 15,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => LoginSpid())));
                                },
                                child: const Text('Accesso FFOO o CUP'),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: Text(
                                'Sei un utente frocio e vuoi denunciare tua madre? Accedi con SPID.',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
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
      ),
      // ),
    );
  }
}
