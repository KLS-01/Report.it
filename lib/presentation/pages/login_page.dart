import 'package:flutter/material.dart';
import 'package:report_it/presentation/pages/login_workers_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    String workerFFOO = 'FFOO';
    String workerASL = 'ASL';

    return MaterialApp(
      title: "Report.it",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(
            child: Container(
              height: ((MediaQuery.of(context).size.height)),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 50, bottom: 50),
              child: Card(
                color: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/img/logo_report_it.png",
                        scale: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton.extended(
                              heroTag: "btnSPID",
                              onPressed: () {},
                              label: const Text("SPID"),
                              icon: const Icon(Icons.person),
                              backgroundColor:
                                  const Color.fromARGB(255, 45, 59, 212),
                              foregroundColor: Colors.yellow,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton.extended(
                              heroTag: "btnFFOO",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LoginWorker(workerType: workerFFOO),
                                  ),
                                );
                              },
                              label: const Text("FFOO"),
                              icon: const Icon(Icons.local_police),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.red,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            FloatingActionButton.extended(
                              heroTag: "btnASL",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LoginWorker(workerType: workerASL),
                                  ),
                                );
                              },
                              label: const Text("ASL  "),
                              icon: const Icon(Icons.local_hospital),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
