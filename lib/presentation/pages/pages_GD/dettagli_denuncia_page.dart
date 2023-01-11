import 'package:cloud_firestore/cloud_firestore.dart';
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
  _DettagliDenunciaRebeccaState(
      {required this.denunciaId, required this.utente});

  late Stream<DocumentSnapshot<Map<String,dynamic>>> denuncia;
  String denunciaId;
  SuperUtente utente;



  @override
  void initState() {
    super.initState();
    denuncia = DenunciaController().generaStreamDenunciaById(denunciaId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(219, 29, 69, 1),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          StreamBuilder(
              stream: denuncia,
              builder: (BuildContext context,snapshot) {
                if (snapshot.hasError) {
                  return Text("Errore nello snapshot");
                }else{
                  switch(snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("Dati denuncia non trovati");
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                      break;
                    case ConnectionState.active:{
                      var json= snapshot.data?.data();
                      Denuncia d= DenunciaController().jsonToDenunciaDettagli(json!);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'Dati anagrafici',
                                  labelStyle: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nome: ${d.nomeDenunciante}'),
                                    Text('Cognome: ${d.cognomeDenunciante}'),
                                    Text('Indirizzo: ${d.indirizzoDenunciante}'),
                                    Text('CAP: ${d.capDenunciante}'),
                                    Text('Sigla provincia: ${d.provinciaDenunciante}'),
                                    Text('Numero di telefono: ${d.cellulareDenunciante}'),
                                    Text('E-mail: ${d.emailDenunciante}'),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Discriminazione',
                                  labelStyle: TextStyle(fontSize: 30),
                                ),
                                child: Text('Natura della discriminazione: ${d.descrizione}'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Vittima',
                                  labelStyle: TextStyle(fontSize: 30),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nome: ${d.nomeVittima}'),
                                    Text('Cognome: ${d.cognomeVittima}'),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Oppressore',
                                  labelStyle: TextStyle(fontSize: 30),
                                ),
                                child: Text('Nome oppressore: ${d.denunciato}'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Vicenda',
                                  labelStyle: TextStyle(fontSize: 30),
                                ),
                                child: Text('Dettagli della vicenda: '),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Consenso',
                                  labelStyle: TextStyle(fontSize: 30),
                                ),
                                child: Text('Consenso: ${d.alreadyFiled}'),
                              ),
                            ),
                            generaTasto(d, utente),
                          ],
                        ),
                      );
                    }
                    case ConnectionState.done:{
                      var json= snapshot.data?.data();
                      Denuncia d= DenunciaController().jsonToDenunciaDettagli(json!);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            generaTasto(d, utente),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'Dati anagrafici',
                                  labelStyle: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nome: ${d.nomeDenunciante}'),
                                    Text('Cognome: ${d.cognomeDenunciante}'),
                                    Text('Indirizzo: ${d.indirizzoDenunciante}'),
                                    Text('CAP: ${d.capDenunciante}'),
                                    Text('Sigla provincia: ${d.provinciaDenunciante}'),
                                    Text('Numero di telefono: ${d.cellulareDenunciante}'),
                                    Text('E-mail: ${d.emailDenunciante}'),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Discriminazione',
                                  labelStyle: TextStyle(fontSize: 30),
                                ),
                                child: Text('Natura della discriminazione: ${d.descrizione}'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Vittima',
                                  labelStyle: TextStyle(fontSize: 30),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nome: ${d.nomeVittima}'),
                                    Text('Cognome: ${d.cognomeVittima}'),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Oppressore',
                                  labelStyle: TextStyle(fontSize: 30),
                                ),
                                child: Text('Nome oppressore: ${d.denunciato}'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Vicenda',
                                  labelStyle: TextStyle(fontSize: 30),
                                ),
                                child: Text('Dettagli della vicenda: '),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Consenso',
                                  labelStyle: TextStyle(fontSize: 30),
                                ),
                                child: Text('Consenso: ${d.alreadyFiled}'),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                  }
                }
              },
            ),
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
