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
                                RichText(
                                  text: TextSpan(
                                    text: "Nome: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "${d.nomeDenunciante}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Cognome: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "${d.cognomeDenunciante}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Indirizzo: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "${d.indirizzoDenunciante}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "CAP: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "${d.capDenunciante}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Provincia: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "${d.provinciaDenunciante}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Cellulare: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "${d.cellulareDenunciante}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "E-mail: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "${d.emailDenunciante}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Consumer<SuperUtente?>(
                                  builder: (context, utente, _) {
                                    if (utente?.tipo == TipoUtente.UffPolGiud) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text:
                                                  "Tipo documento del denunciante: ",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${d.tipoDocDenunciante}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: "Numero documento: ",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${d.numeroDocDenunciante}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: "Scadenza documento: ",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${d.scadenzaDocDenunciante}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                RichText(
                                  text: TextSpan(
                                    text: "Nome: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "${d.nomeVittima}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Cognome: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "${d.cognomeVittima}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
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
                            child: RichText(
                              text: TextSpan(
                                text: "Nome oppressore: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${d.denunciato}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
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
                              labelText: 'Info sulla pratica',
                              labelStyle: ThemeText.titoloDettaglio,
                              border: InputBorder.none,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: "Presentata in precedenza: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: d.alreadyFiled ? "sì" : "no",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            "Ufficiale di Polizia Giudiziaria: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                "${d.cognomeUff} ${d.nomeUff}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "Grado: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "${d.gradoUff}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "Tipo di Ufficiale: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "${d.tipoUff}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "Caserma di riferimento: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "${d.nomeCaserma}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            "Indirizzo caserma: VIA, CAP, CITTÀ: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "${d.coordCaserma}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
