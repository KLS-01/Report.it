import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/data/Models/denuncia_dao.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/domain/entity/entity_GD/stato_denuncia.dart';
import '../../../domain/entity/entity_GD/denuncia_entity.dart';
import '../../../../domain/repository/denuncia_controller.dart';
import 'inoltro_denuncia_page.dart';

class DettagliDenunciaRebecca extends StatefulWidget {
  const DettagliDenunciaRebecca(
      {super.key, required this.denunciaId, required this.utente});
  final String denunciaId;
  final SuperUtente utente;

  @override
  State<DettagliDenunciaRebecca> createState() =>
      _DettagliDenunciaRebeccaState(denunciaId: denunciaId, utente: utente);
}

class _DettagliDenunciaRebeccaState extends State<DettagliDenunciaRebecca> {
  late Future<Denuncia?> denuncia;
  String denunciaId;
  SuperUtente utente;

  _DettagliDenunciaRebeccaState(
      {required this.denunciaId, required this.utente});

  @override
  void initState() {
    super.initState();
    denuncia = DenunciaController().visualizzaDenunciaById(denunciaId, utente);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Color.fromRGBO(219, 29, 69, 1)),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          FutureBuilder<Denuncia?>(
              future: denuncia,
              builder:
                  (BuildContext context, AsyncSnapshot<Denuncia?> snapshot) {
                if (snapshot.data == null) {
                  return const Text("Errore denuncia non trovata");
                } else {
                  String? descrizione = snapshot.data?.descrizione;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          color: Colors.amber,
                          child: InputDecorator(
                            decoration:
                                InputDecoration(labelText: 'Dati anagrafici'),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nome: '),
                                Text('Cognome: '),
                                Text('Indirizzo: '),
                                Text('CAP: '),
                                Text('Sigla provincia: '),
                                Text('Numero di telefono: '),
                                Text('E-mail: '),
                              ],
                            ),
                          ),
                        ),
                        // generaTasto(snapshot.data!, utente)
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          color: Colors.green,
                          child: InputDecorator(
                            decoration:
                                InputDecoration(labelText: 'Discriminazione'),
                            child: Text('Natura della discriminazione'),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          color: Colors.lightBlue,
                          child: InputDecorator(
                            decoration: InputDecoration(labelText: 'Vittima'),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nome'),
                                Text('Cognome'),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          color: Colors.amber,
                          child: InputDecorator(
                            decoration:
                                InputDecoration(labelText: 'Oppressore'),
                            child: Text('Nome oppressore'),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          color: Colors.green,
                          child: InputDecorator(
                            decoration: InputDecoration(labelText: 'Vicenda'),
                            child: Text('Dettagli della vicenda'),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          color: Colors.lightBlue,
                          child: InputDecorator(
                            decoration: InputDecoration(labelText: 'Consenso'),
                            child: Text('Consenso'),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}

Widget generaTasto(Denuncia denuncia, SuperUtente utente) {
  if (utente.tipo == TipoUtente.UffPolGiud) {
    switch (denuncia.statoDenuncia) {
      case StatoDenuncia.NonInCarico:
        return ElevatedButton(
            onPressed: () {
              DenunciaController().accettaDenuncia(denuncia, utente);
            },
            child: const Text("Accetta"));
      case StatoDenuncia.PresaInCarico:
        return ElevatedButton(
            onPressed: () =>
                DenunciaController().chiudiDenuncia(denuncia, utente) == true
                    ? print("denuncia chiusa")
                    : print("denuncia non chiusa"),
            child: const Text("Chiudi"));
      case StatoDenuncia.Chiusa:
        return ElevatedButton(
            onPressed: () {}, child: const Text("Non puoi fare nulla"));
    }
  } else {
    return const Visibility(visible: false, child: Text(""));
  }
}
