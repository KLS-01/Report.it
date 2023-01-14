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
          // if(utente.tipo == TipoUtente.UffPolGiud){
          //   Container(
          //                         decoration: BoxDecoration(
          //                           color: Colors.white,
          //                           borderRadius: BorderRadius.circular(20),
          //                           boxShadow: [
          //                             BoxShadow(
          //                               color: Colors.grey.withOpacity(0.2),
          //                               blurRadius: 8.0,
          //                               spreadRadius: 1.0,
          //                               offset: Offset(0, 3),
          //                             )
          //                           ],
          //                         ),
          //                         padding: const EdgeInsets.symmetric(
          //                             vertical: 10, horizontal: 20),
          //                         margin: const EdgeInsets.symmetric(
          //                             vertical: 10, horizontal: 20),
          //                         child: InputDecorator(
          //                           decoration: const InputDecoration(
          //                             labelText: 'Presa in carico da:',
          //                             labelStyle: TextStyle(
          //                               fontSize: 30,
          //                               fontWeight: FontWeight.bold,
          //                             ),
          //                             border: InputBorder.none,
          //                           ),
          //                           child: SingleChildScrollView(
          //                             scrollDirection: Axis.horizontal,
          //                             child: Column(
          //                               crossAxisAlignment:
          //                                   CrossAxisAlignment.start,
          //                               children: [
          //                                 Row(
          //                                   children: [
          //                                     Text(
          //                                       'Ufficiale di Polizia Giudiziaria: ',
          //                                       style: TextStyle(
          //                                           fontWeight:
          //                                               FontWeight.bold),
          //                                     ),
          //                                     Text('chiamata dal back'),
          //                                   ],
          //                                 ),
          //                                 Row(
          //                                   children: [
          //                                     Text(
          //                                       'Grado: ',
          //                                       style: TextStyle(
          //                                           fontWeight:
          //                                               FontWeight.bold),
          //                                     ),
          //                                     Text('chiamata dal back'),
          //                                   ],
          //                                 ),
          //                                 Row(
          //                                   children: [
          //                                     Text(
          //                                       'Tipo di Ufficiale: (carabinieri blabla)',
          //                                       style: TextStyle(
          //                                           fontWeight:
          //                                               FontWeight.bold),
          //                                     ),
          //                                     Text('chiamata dal back'),
          //                                   ],
          //                                 ),
          //                                 Row(
          //                                   children: [
          //                                     Text(
          //                                       'Caserma di riferimento: ',
          //                                       style: TextStyle(
          //                                           fontWeight:
          //                                               FontWeight.bold),
          //                                     ),
          //                                     Text('chiamata dal back'),
          //                                   ],
          //                                 ),
          //                                 Row(
          //                                   children: [
          //                                     Text(
          //                                       'Indirizzo caserma: VIA, CAP, CITTA\' ',
          //                                       style: TextStyle(
          //                                           fontWeight:
          //                                               FontWeight.bold),
          //                                     ),
          //                                     Text('chiamata dal back'),
          //                                   ],
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         )),
          // }
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
                              generaStatoDenuncia(d.statoDenuncia),
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
                                      color: Colors.black,
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
                                      color: Colors.black,
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
                                      color: Colors.black,
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
                                      color: Colors.black,
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
                                      color: Colors.black,
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
                                      color: Colors.black,
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
                              Consumer<SuperUtente?>(
                                  builder: (context, utente, _) {
                                if (utente?.tipo == TipoUtente.Utente) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.redAccent,
                                          blurRadius: 8.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: InputDecorator(
                                      decoration: const InputDecoration(
                                        labelText: 'Presa in carico da:',
                                        labelStyle: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Ufficiale di Polizia Giudiziaria: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    '${d.cognomeUff} ${d.nomeUff}'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Grado: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    'INSERIRE IL GRADO DEL DB'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Tipo di Ufficiale:',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    'INSERIRE TIPO NEL DB  (carabinieri blabla)'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Caserma di riferimento: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('${d.nomeCaserma}'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Indirizzo caserma: VIA, CAP, CITTA\' ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('${d.coordCaserma}'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ); //MARISA ECCO IL TUO CONTAINER <3
                                } else {
                                  return Visibility(
                                      child: Text(""), visible: false);
                                }
                              }),
                              generaTastoCambiaStato(
                                  denuncia: d, utente: utente),
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
                              generaTastoCambiaStato(
                                  denuncia: d, utente: utente),
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

class generaTastoCambiaStato extends StatelessWidget {
  const generaTastoCambiaStato(
      {Key? key, required this.denuncia, required this.utente})
      : super(key: key);
  final Denuncia denuncia;
  final SuperUtente utente;

  @override
  Widget build(BuildContext context) {
    if (utente.tipo == TipoUtente.UffPolGiud) {
      switch (denuncia.statoDenuncia) {
        case StatoDenuncia.NonInCarico:
          return ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                textStyle: MaterialStateProperty.all(
                    Theme.of(context).textTheme.button),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(219, 29, 69, 1),
                ),
              ),
              onPressed: () =>
                  showAlertDialogAccetta(context, denuncia, utente),
              child: const Text("Accetta"));
        case StatoDenuncia.PresaInCarico:
          return ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                textStyle: MaterialStateProperty.all(
                    Theme.of(context).textTheme.button),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(219, 29, 69, 1),
                ),
              ),
              onPressed: () => showAlertDialogChiudi(context, denuncia, utente),
              child: const Text("Chiudi"));
        case StatoDenuncia.Chiusa:
          return Visibility(
            visible: false,
            child: Text(""),
          );
      }
    } else {
      return const Visibility(visible: false, child: Text(""));
    }
  }

  showAlertDialogAccetta(
      BuildContext context, Denuncia denuncia, SuperUtente utente) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Attenzione!!!!!!"),
          content: Text("Sei sicuro di accettare la denuncia?"),
          actions: [
            ElevatedButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context, "Cancel"),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                textStyle: MaterialStateProperty.all(
                    Theme.of(context).textTheme.button),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(219, 29, 69, 1),
                ),
              ),
            ),
            ElevatedButton(
              child: Text("Continue"),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                textStyle: MaterialStateProperty.all(
                    Theme.of(context).textTheme.button),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(219, 29, 69, 1),
                ),
              ),
              onPressed: () {
                DenunciaController.accettaDenuncia(denuncia, utente);
                Navigator.pop(context, "Continue");
              },
            ),
          ],
        );
      },
    );
  }

  showAlertDialogChiudi(
      BuildContext context, Denuncia denuncia, SuperUtente utente) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Attenzione!!!!!!"),
          content: Text("Sei sicuro di voler chiudere la pratica?"),
          actions: [
            ElevatedButton(
              child: Text("NO"),
              onPressed: () => Navigator.pop(context, "Cancel"),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                textStyle: MaterialStateProperty.all(
                    Theme.of(context).textTheme.button),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(219, 29, 69, 1),
                ),
              ),
            ),
            ElevatedButton(
              child: Text("SI"),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                textStyle: MaterialStateProperty.all(
                    Theme.of(context).textTheme.button),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(219, 29, 69, 1),
                ),
              ),
              onPressed: () {
                DenunciaController().chiudiDenuncia(denuncia, utente);
                Navigator.pop(context, "Continue");
              },
            ),
          ],
        );
      },
    );
  }
}

Widget generaStatoDenuncia(StatoDenuncia stato) {
  switch (stato) {
    case StatoDenuncia.NonInCarico:
      {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 8.0,
                spreadRadius: 1.0,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            'In attesa',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    case StatoDenuncia.PresaInCarico:
      {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 8.0,
                spreadRadius: 1.0,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            'Presa in carico',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    case StatoDenuncia.Chiusa:
      {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 8.0,
                spreadRadius: 1.0,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            'Chiusa',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
  }
}
