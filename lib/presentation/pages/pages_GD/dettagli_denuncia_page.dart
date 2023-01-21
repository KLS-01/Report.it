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
import '../../widget/tasto_cambia_stato_denuncia_widget.dart';

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
                  }
                  if (snapshot.connectionState == ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    var json = snapshot.data?.data();
                    Denuncia d =
                        DenunciaController().jsonToDenunciaDettagli(json!);
                    return Column(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                Consumer<SuperUtente?>(
                                  builder: (context, utente, _) {
                                    if (utente?.tipo == TipoUtente.UffPolGiud) {
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Tipo documento del denunciante: ${d.tipoDocDenunciante}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow: TextOverflow.fade,
                                                ),
                                              ),
                                              // Text(
                                              //     ' ${d.tipoDocDenunciante}'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Numero documento: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text('${d.numeroDocDenunciante}'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Scadenza documento: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text('${d.numeroDocDenunciante}'),
                                            ],
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                )
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
                              labelText: 'Categoria discriminazione',
                              labelStyle: ThemeText.titoloDettaglio,
                              border: InputBorder.none,
                            ),
                            child: Text(d.categoriaDenuncia.name,
                                overflow: TextOverflow.fade),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                            child: Text(d.descrizione,
                                overflow: TextOverflow.fade),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('${d.alreadyFiled}'),
                              ],
                            ),
                          ),
                        ),
                        Consumer<SuperUtente?>(builder: (context, utente, _) {
                          if (utente?.tipo == TipoUtente.Utente &&
                              d.statoDenuncia != StatoDenuncia.NonInCarico) {
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
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.cognomeUff} ${d.nomeUff}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Grado: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.gradoUff}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Tipo di Ufficiale:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.tipoUff}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Caserma di riferimento: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${d.nomeCaserma}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Indirizzo caserma: VIA, CAP, CITTA\' ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
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
                        generaTastoCambiaStato(denuncia: d, utente: utente),
                      ],
                    );
                  } else {
                    return const Text("");
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
