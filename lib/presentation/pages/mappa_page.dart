import 'package:flutter/material.dart';
import 'package:report_it/presentation/pages/inoltro_denuncia_page.dart';

class Mappa extends StatelessWidget {
  const Mappa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InoltroDenuncia(),
            ),
          );
        }),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
