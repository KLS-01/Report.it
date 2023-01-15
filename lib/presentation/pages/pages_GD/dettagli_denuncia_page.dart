import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/domain/entity/entity_GD/stato_denuncia.dart';
import 'package:report_it/presentation/widget/styles.dart';
import '../../../domain/entity/entity_GD/denuncia_entity.dart';
import '../../../../domain/repository/denuncia_controller.dart';

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
        title: const Text(
          'Sezione Denunce',
          style: ThemeText.titoloSezione,
        ),
        iconTheme: const IconThemeData(
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
                  return const Text("Errore nello snapshot.");
                } else {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Text("Dati denuncia non trovati.");
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
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
                                decoration: ThemeText.boxDettaglio,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    labelText: 'Dati anagrafici',
                                    labelStyle: ThemeText.titoloDettaglio,
                                    border: InputBorder.none,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Nome: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.nomeDenunciante}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Cognome: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.cognomeDenunciante}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Indirizzo: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.indirizzoDenunciante}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'CAP: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.capDenunciante}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Provincia: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.provinciaDenunciante}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Cellulare: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.cellulareDenunciante}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
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
                                decoration: ThemeText.boxDettaglio,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    labelText: 'Discriminazione',
                                    labelStyle: ThemeText.titoloDettaglio,
                                    border: InputBorder.none,
                                  ),
                                  child: Row(
                                    children: [
                                      const Text(
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
                                decoration: ThemeText.boxDettaglio,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    labelText: 'Vittima',
                                    labelStyle: ThemeText.titoloDettaglio,
                                    border: InputBorder.none,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Nome: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.nomeVittima}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
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
                                decoration: ThemeText.boxDettaglio,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    labelText: 'Oppressore',
                                    labelStyle: ThemeText.titoloDettaglio,
                                    border: InputBorder.none,
                                  ),
                                  child: Row(
                                    children: [
                                      const Text(
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
                                decoration: ThemeText.boxDettaglio,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    labelText: 'Vicenda',
                                    labelStyle: ThemeText.titoloDettaglio,
                                    border: InputBorder.none,
                                  ),
                                  child: Row(
                                    children: const [
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
                                decoration: ThemeText.boxDettaglio,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    labelText: 'Consenso',
                                    labelStyle: ThemeText.titoloDettaglio,
                                    border: InputBorder.none,
                                  ),
                                  child: Row(
                                    children: [
                                      const Text(
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
                                    decoration: ThemeText.boxRossoDettaglio,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: InputDecorator(
                                      decoration: const InputDecoration(
                                        labelText: 'Presa in carico da:',
                                        labelStyle: ThemeText.titoloDettaglio,
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
                                                const Text(
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
                                              children: const [
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
                                              children: const [
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
                                                const Text(
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
                                                const Text(
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
                                  );
                                } else {
                                  return const Visibility(
                                      visible: false, child: Text(""));
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
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    labelText: 'Dati anagrafici',
                                    labelStyle: ThemeText.titoloDettaglio,
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
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    labelText: 'Discriminazione',
                                    labelStyle: TextStyle(fontSize: 30),
                                  ),
                                  child: Text(
                                      'Natura della discriminazione: ${d.descrizione}'),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
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
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    labelText: 'Oppressore',
                                    labelStyle: TextStyle(fontSize: 30),
                                  ),
                                  child:
                                      Text('Nome oppressore: ${d.denunciato}'),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: const InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: 'Vicenda',
                                    labelStyle: TextStyle(fontSize: 30),
                                  ),
                                  child: Text('Dettagli della vicenda: '),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
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
              style: ThemeText.bottoneRosso,
              onPressed: () =>
                  showAlertDialogAccetta(context, denuncia, utente),
              child: const Text("Prendi in carico"));
        case StatoDenuncia.PresaInCarico:
          return ElevatedButton(
              style: ThemeText.bottoneRosso,
              onPressed: () => showAlertDialogChiudi(context, denuncia, utente),
              child: const Text("Chiudi la pratica"));
        case StatoDenuncia.Chiusa:
          return const Visibility(
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
          title: const Text("Attenzione!", style: ThemeText.titoloAlert),
          content: const Text(
              "Sei sicuro di voler prendere in carico la denuncia?",
              style: ThemeText.corpoInoltro),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, "Cancel"),
              style: ThemeText.bottoneRosso,
              child: const Text("Torna indietro"),
            ),
            ElevatedButton(
              style: ThemeText.bottoneRosso,
              onPressed: () {
                DenunciaController.accettaDenuncia(denuncia, utente);
                Navigator.pop(context, "Continue");
              },
              child: const Text("Prendi in carico"),
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
          title: const Text("Attenzione!", style: ThemeText.titoloAlert),
          content: const Text("Sei sicuro di voler chiudere la pratica?",
              style: ThemeText.corpoInoltro),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, "Cancel"),
              style: ThemeText.bottoneRosso,
              child: const Text("No"),
            ),
            ElevatedButton(
              style: ThemeText.bottoneRosso,
              onPressed: () {
                DenunciaController().chiudiDenuncia(denuncia, utente);
                Navigator.pop(context, "Continue");
              },
              child: const Text("Sì"),
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
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: ThemeText.bottoneInAttesa,
          child: const Text(
            'In attesa',
            style: ThemeText.titoloInoltro,
          ),
        );
      }
    case StatoDenuncia.PresaInCarico:
      {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: ThemeText.bottoneInCarico,
          child: const Text(
            'Presa in carico',
            style: ThemeText.titoloInoltro,
          ),
        );
      }
    case StatoDenuncia.Chiusa:
      {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: ThemeText.bottoneChiusa,
          child: const Text(
            'Chiusa',
            style: ThemeText.titoloInoltro,
          ),
        );
      }
  }
}
