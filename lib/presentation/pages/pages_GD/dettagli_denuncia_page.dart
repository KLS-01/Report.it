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

  late Stream<DocumentSnapshot<Map<String, dynamic>>> denuncia;
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
        title: Text(
          'Dettagli denuncia',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'SourceSerifPro'),
        ),
        iconTheme: IconThemeData(
          color: Color.fromRGBO(219, 29, 69, 1),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: denuncia,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Errore nello snapshot");
                } else {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("Dati denuncia non trovati");
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                      break;
                    case ConnectionState.active:
                      {
                        var json = snapshot.data?.data();
                        Denuncia d =
                            DenunciaController().jsonToDenunciaDettagli(json!);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 8.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    labelText: 'Dati anagrafici',
                                    labelStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Nome: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.nomeDenunciante}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Cognome: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.cognomeDenunciante}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Indirizzo: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.indirizzoDenunciante}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'CAP: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.capDenunciante}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Provincia: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.provinciaDenunciante}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Cellulare: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.cellulareDenunciante}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'E-mail: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.emailDenunciante}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 8.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: 'Discriminazione',
                                    labelStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Natura della discriminazione: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('${d.descrizione}'),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 8.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: 'Vittima',
                                    labelStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Nome: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.nomeVittima}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Cognome: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.cognomeVittima}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 8.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: 'Oppressore',
                                    labelStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Nome oppressore: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('${d.denunciato}'),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 8.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: 'Vicenda',
                                    labelStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Dettagli della vicenda: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 8.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: 'Consenso',
                                    labelStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Consenso: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('${d.alreadyFiled}'),
                                    ],
                                  ),
                                ),
                              ),
                              generaTasto(d, utente),
                            ],
                          ),
                        );
                      }
                    case ConnectionState.done:
                      {
                        var json = snapshot.data?.data();
                        Denuncia d =
                            DenunciaController().jsonToDenunciaDettagli(json!);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Nome: ${d.nomeDenunciante}'),
                                      Text('Cognome: ${d.cognomeDenunciante}'),
                                      Text(
                                          'Indirizzo: ${d.indirizzoDenunciante}'),
                                      Text('CAP: ${d.capDenunciante}'),
                                      Text(
                                          'Sigla provincia: ${d.provinciaDenunciante}'),
                                      Text(
                                          'Numero di telefono: ${d.cellulareDenunciante}'),
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
                                  child: Text(
                                      'Natura della discriminazione: ${d.descrizione}'),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  child:
                                      Text('Nome oppressore: ${d.denunciato}'),
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
