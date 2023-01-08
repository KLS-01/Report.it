import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:report_it/domain/entity/prenotazione_entity.dart';

class InformazioniPrenotazione extends StatefulWidget {
  const InformazioniPrenotazione({Key? key}) : super(key: key);

  @override
  State<InformazioniPrenotazione> createState() => _InformazioniPrenotazione();
}

class _InformazioniPrenotazione extends State<InformazioniPrenotazione> {
  late Future<Prenotazione> prenotazione;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 10),
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(context);
            },
            child: const Text("Torna indietro")),
      ),
      Padding(
        padding: const EdgeInsets.all(50),
        child: Column(children: [
          const Text("Info"),
          const Text("ID prenotazione"),
        ]),
      )
    ]));
  }
}
