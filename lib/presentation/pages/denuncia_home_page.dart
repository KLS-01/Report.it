import 'package:flutter/material.dart';

class Denunce extends StatelessWidget {
  const Denunce({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'SEZIONE DENUNCE',
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
