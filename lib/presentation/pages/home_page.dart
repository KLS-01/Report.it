import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/repository/authentication_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
