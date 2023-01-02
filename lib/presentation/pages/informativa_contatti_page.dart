import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../domain/repository/authentication_service.dart';

class InformativaContatti extends StatelessWidget {
  const InformativaContatti({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "HOMEPAGE",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 20,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  context.read<AuthenticationService>().signOut();
                },
                label: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
