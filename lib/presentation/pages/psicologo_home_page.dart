import 'package:flutter/material.dart';

class Psicologo extends StatelessWidget {
  const Psicologo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'SEZIONE PSICOLOGO',
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
