import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:report_it/presentation/pages/login_user_page.dart';

import 'navigation_animations.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    String userWorker = 'WRK';
    String userSPID = 'SPID';

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
                      mainAxisAlignment: MainAxisAlignment.end,
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
                        Container(
                          margin: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(20),
                              minimumSize: const Size(double.infinity, 20),
                              backgroundColor: Colors.green,
                              elevation: 15,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(createRouteTo(
                                  LoginWorker(userType: userWorker)));
                            },
                            child: const Text(
                              'Accesso FFOO o CUP',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(30, 60, 30, 20),
                          child: const Text(
                            'Report.it garantisce che il trattamento dei dati'
                            'personali si svolga nel rispetto dei diritti, '
                            'delle libertà fondamentali, nonché della dignità '
                            'delle persone fisiche, con particolare riferimento'
                            ' alla riservatezza e all´identità personale '
                            '(secondo quanto enunciato dall\'art.1, d.lg.675 31 Dicembre 1996)',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
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
