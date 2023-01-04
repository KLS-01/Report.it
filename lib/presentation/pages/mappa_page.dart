import 'package:flutter/material.dart';

class Mappa extends StatelessWidget {
  const Mappa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'SEZIONE MAPPA',
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
