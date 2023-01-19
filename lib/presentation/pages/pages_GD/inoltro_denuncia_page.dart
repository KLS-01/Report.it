import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/entity_GA/spid_entity.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/domain/entity/entity_GD/categoria_denuncia.dart';
import 'package:report_it/domain/repository/denuncia_controller.dart';

import '../../../domain/entity/entity_GA/super_utente.dart';
import '../../widget/styles.dart';

class InoltroDenuncia extends StatefulWidget {
  final SuperUtente utente;
  InoltroDenuncia({required this.utente});

  @override
  _InoltroDenuncia createState() => _InoltroDenuncia(utente: utente);
}

class _InoltroDenuncia extends State<InoltroDenuncia> {
  _InoltroDenuncia({required this.utente});
  final SuperUtente utente;

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  final TextEditingController nameController =
      TextEditingController(text: 'Mario');
  final TextEditingController surnameController =
      TextEditingController(text: 'Rossi');
  final TextEditingController numberController =
      TextEditingController(text: '3336549875');
  final TextEditingController indirizzoController = TextEditingController(
      text:
          'via cilea,1'); //TODO: correggere la regex, legge un solo numero dopo la virgola obbligatoria
  final TextEditingController capController =
      TextEditingController(text: '82091');
  final TextEditingController provinciaController =
      TextEditingController(text: 'RO');
  final TextEditingController emailController =
      TextEditingController(text: 'mario@gmail.com');
  final TextEditingController oppressoreController =
      TextEditingController(text: 'Leonardo Schiavo');
  final TextEditingController nomeVittimaController =
      TextEditingController(text: 'Biscotto');
  final TextEditingController cognomeVittimaController =
      TextEditingController(text: 'Frugieri');
  final TextEditingController descrizioneController = TextEditingController();

  final regexEmail = RegExp(r"^[A-z0-9\.\+_-]+@[A-z0-9\._-]+\.[A-z]{2,6}$");
  //   r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final regexIndirizzo = RegExp(r"^[a-zA-Z+\s]+[,]\s?[0-9]+$");
  final regexCap = RegExp(r"^[0-9]{5}$");
  final regexProvincia = RegExp(r"^[a-zA-Z]{2}$");
  final regexCellulare = RegExp(r"^((00|\+)39[\. ]??)??3\d{2}[\. ]??\d{6,7}$");

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String? discriminazione;
  String? vittima1, vittima2;
  String? consenso1, consenso2;
  bool consensoController = false;
  late SPID? spidUtente;

  @override
  Widget build(BuildContext context) {
    final consenso_widget = Wrap(
      children: [
        Column(
          children: <Widget>[
            const Text(
              "Rilascia il consenso all'Ufficiale di Polizia Giudiziaria di condividere il Suo nome ed altre informazioni personali con altre parti inerenti a questo caso quando così facendo si collabora nell’investigazione e nella risoluzione del Suo reclamo?",
              style: ThemeText.corpoInoltro,
            ),
            RadioListTile(
              title: const Text("Sì"),
              value: "Si",
              groupValue: consenso1,
              onChanged: ((value) {
                setState(() {
                  consenso1 = value.toString();
                  consenso2 = null;
                  consensoController = true;
                });
              }),
            ),
            RadioListTile(
              title: const Text("No"),
              value: "No",
              groupValue: consenso2,
              onChanged: ((value) {
                setState(() {
                  consenso2 = value.toString();
                  consenso1 = null;
                });
              }),
            ),
          ],
        ),
        (consenso2) != null
            ? Flexible(
                flex: 0,
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:
                            Text("Attenzione!", style: ThemeText.titoloAlert),
                      ),
                      Text(
                        "Bisogna necessariamente accettare il consenso per poter inoltra correttamente tale denuncia.",
                        style: ThemeText.corpoInoltro,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              )
            : Column(),
        //se il consenso "sì" --> allora il bottone viene mostrato
        (consenso1) != null
            ? Container(
                height: 100,
                child: Flexible(
                  flex: 0,
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            addRecord();
                            Navigator.pop(context);

                            Fluttertoast.showToast(
                                msg: "Inoltro avvenuto correttamente!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.grey.shade200,
                                textColor: Colors.black,
                                fontSize: 15.0);
                          },
                          style: ThemeText.bottoneRosso,
                          child: const Text(
                            "Inoltra",
                          ),
                        ),
                      )),
                ),
              )
            : Column(),
      ],
    );

    final vittima_widget = Wrap(
      children: [
        Column(
          children: <Widget>[
            const Text(
              "Chi ritiene essere stato vittima di discriminazione?",
              style: ThemeText.corpoInoltro,
            ),
            RadioListTile(
              title: const Text("Lei stesso"),
              value: "LeiStesso",
              groupValue: vittima1,
              onChanged: ((value) {
                setState(() {
                  vittima1 = value.toString();
                  vittima2 = null;
                });
              }),
            ),
            RadioListTile(
              title: const Text("Persona terza"),
              value: "PersonaTerza",
              groupValue: vittima2,
              onChanged: ((value) {
                setState(() {
                  vittima2 = value.toString();
                  vittima1 = null;
                });
              }),
            ),
          ],
        ),
        (vittima2) != null
            ? Flexible(
                flex: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 5),
                    const Text(
                      "Scrivi qui il nome della presunta vittima: ",
                      style: ThemeText.corpoInoltro,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Nome vittima'),
                      controller: nomeVittimaController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Per favore, inserisci il nome della vittima';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Cognome vittima'),
                      controller: cognomeVittimaController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Per favore, inserisci il cognome della vittima';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              )
            : Column(),
      ],
    );

    return Consumer<SuperUtente?>(
      builder: (context, utente, _) {
        if (utente == null) {
          return const Text("Non sei loggato");
        } else if (utente.tipo != TipoUtente.Utente) {
          return const Text("non hai i permessi per questa funzionalità");
        } else {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              iconTheme: const IconThemeData(
                color: Color.fromRGBO(219, 29, 69, 1),
              ),
              title: const Text(
                "Modulo inoltro denuncia",
                style: ThemeText.titoloSezione,
              ),
              elevation: 3,
              backgroundColor: Theme.of(context).backgroundColor,
            ),
            body: Theme(
              data: ThemeData(
                colorScheme: const ColorScheme.light(
                    primary: Color.fromRGBO(219, 29, 69, 1)),
              ),
              child: Stepper(
                controlsBuilder: (context, details) {
                  if (_currentStep == 0) {
                    return Row(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Nome'),
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Per favore, inserisci il nome';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Cognome'),
                          controller: surnameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Per favore, inserisci il cognome';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Indirizzo'),
                          controller: indirizzoController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Per favore, inserisci un indirizzo';
                            } else if (!regexIndirizzo.hasMatch(value)) {
                              return 'Per favore, inserisci un indirizzo valida';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'CAP'),
                          controller: capController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Per favore, inserisci il CAP';
                            } else if (!regexCap.hasMatch(value)) {
                              return 'Per favore, inserisci un CAP valido';
                            }

                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Sigla provincia'),
                          controller: provinciaController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Per favore, inserisci la provincia';
                            } else if (!regexProvincia.hasMatch(value)) {
                              return 'Per favore, inserisci una provincia valida';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: numberController,
                          decoration: const InputDecoration(
                              labelText: 'Numero telefonico'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Per favore, inserisci il numero telefonico';
                            } else if (!regexCellulare.hasMatch(value)) {
                              return 'Per favore, inserisci una provincia valida';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: const InputDecoration(
                              labelText: 'Indirizzo e-mail'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Per favore, inserisci l\'indirizzo e-mail';
                            } else if (!regexEmail.hasMatch(value)) {
                              return 'Per favore, inserisci una e-mail valida';
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                          onPressed: details.onStepContinue,
                          style: ThemeText.bottoneRosso,
                          child: const Text('Continua'),
                        ),
                      ],
                    );
                  }
                  if (_currentStep == 5) {
                    return TextButton(
                        onPressed: details.onStepCancel,
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Indietro',
                            style: TextStyle(color: Colors.black),
                          ),
                        ));
                  } else {
                    return Row(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: details.onStepContinue,
                          style: ThemeText.bottoneRosso,
                          child: const Text('Continua'),
                        ),
                        TextButton(
                          onPressed: details.onStepCancel,
                          child: const Text(
                            'Indietro',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  }
                },
                type: stepperType,
                currentStep: _currentStep,
                // onStepTapped: (step) => tapped(step), <- se lo si abilita, l'utente sarà abilitato a viaggiare tra le sezioni
                onStepContinue: continued,
                onStepCancel: cancel,
                steps: <Step>[
                  Step(
                    title: const Text(
                      "Dati anagrafici",
                      style: ThemeText.titoloInoltro,
                    ),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Nome'),
                            controller: nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Per favore, inserisci il nome.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Cognome'),
                            controller: surnameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Per favore, inserisci il cognome.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Indirizzo'),
                            controller: indirizzoController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Per favore, inserisci un indirizzo.';
                              } else if (!regexIndirizzo.hasMatch(value)) {
                                return 'Per favore, inserisci un indirizzo valido.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'CAP'),
                            controller: capController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Per favore, inserisci il CAP.';
                              } else if (!regexCap.hasMatch(value)) {
                                return 'Per favore, inserisci un CAP valido.';
                              }

                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Sigla provincia'),
                            controller: provinciaController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Per favore, inserisci la provincia.';
                              } else if (!regexProvincia.hasMatch(value)) {
                                return 'Per favore, inserisci una provincia valida.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: numberController,
                            decoration: const InputDecoration(
                                labelText: 'Numero telefonico'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Per favore, inserisci il numero telefonico.';
                              } else if (!regexCellulare.hasMatch(value)) {
                                return 'Per favore, inserisci un numero telefonico valido.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: const InputDecoration(
                                labelText: 'Indirizzo e-mail'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Per favore, inserisci l\'indirizzo e-mail';
                              } else if (!regexEmail.hasMatch(value)) {
                                return 'Per favore, inserisci una e-mail valida.';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text("Discriminazione",
                        style: ThemeText.titoloInoltro),
                    content: Form(
                      key: _formKey2,
                      child: Column(
                        children: <Widget>[
                          const Text(
                            "Indicare la natura della presunta discriminazione:",
                            style: ThemeText.corpoInoltro,
                          ),
                          RadioListTile(
                            title: const Text("Etnia"),
                            value: "Etnia",
                            groupValue: discriminazione,
                            onChanged: ((value) {
                              setState(() {
                                discriminazione = value.toString();
                              });
                            }),
                          ),
                          RadioListTile(
                            title: const Text("Colore della pelle"),
                            value: "ColoreDellaPelle",
                            groupValue: discriminazione,
                            onChanged: ((value) {
                              setState(() {
                                discriminazione = value.toString();
                              });
                            }),
                          ),
                          RadioListTile(
                            title: const Text("Disabilità"),
                            value: "Disabilita",
                            groupValue: discriminazione,
                            onChanged: ((value) {
                              setState(() {
                                discriminazione = value.toString();
                              });
                            }),
                          ),
                          RadioListTile(
                            title: const Text("Età"),
                            value: "Eta",
                            groupValue: discriminazione,
                            onChanged: ((value) {
                              setState(() {
                                discriminazione = value.toString();
                              });
                            }),
                          ),
                          RadioListTile(
                            title: const Text("Orientamento Sessuale"),
                            value: "OrientamentoSessuale",
                            groupValue: discriminazione,
                            onChanged: ((value) {
                              setState(() {
                                discriminazione = value.toString();
                              });
                            }),
                          ),
                          RadioListTile(
                            title: const Text("Religione"),
                            value: "Religione",
                            groupValue: discriminazione,
                            onChanged: ((value) {
                              setState(() {
                                discriminazione = value.toString();
                              });
                            }),
                          ),
                          RadioListTile(
                            title: const Text("Stirpe"),
                            value: "Stirpe",
                            groupValue: discriminazione,
                            onChanged: ((value) {
                              setState(() {
                                discriminazione = value.toString();
                              });
                            }),
                          ),
                          RadioListTile(
                            title: const Text("GenereSessuale"),
                            value: "GenereSessuale",
                            groupValue: discriminazione,
                            onChanged: ((value) {
                              setState(() {
                                discriminazione = value.toString();
                              });
                            }),
                          ),
                          RadioListTile(
                            title: const Text("Identità di genere"),
                            value: "IdentitaDiGenere",
                            groupValue: discriminazione,
                            onChanged: ((value) {
                              setState(() {
                                discriminazione = value.toString();
                              });
                            }),
                          ),
                          RadioListTile(
                            title: const Text("Espressione di genere"),
                            value: "EspressioneDiGenere",
                            groupValue: discriminazione,
                            onChanged: ((value) {
                              setState(() {
                                discriminazione = value.toString();
                              });
                            }),
                          ),
                          RadioListTile(
                            title: const Text("Fede"),
                            value: "Fede",
                            groupValue: discriminazione,
                            onChanged: ((value) {
                              setState(() {
                                discriminazione = value.toString();
                              });
                            }),
                          ),
                          RadioListTile(
                            title: const Text("Storia Personale"),
                            value: "StoriaPersonale",
                            groupValue: discriminazione,
                            onChanged: ((value) {
                              setState(() {
                                discriminazione = value.toString();
                              });
                            }),
                          ),
                          RadioListTile(
                            title: const Text("Reddito"),
                            value: "Reddito",
                            groupValue: discriminazione,
                            onChanged: ((value) {
                              setState(() {
                                discriminazione = value.toString();
                              });
                            }),
                          ),
                          RadioListTile(
                            title: const Text("Abusi"),
                            value: "Abusi",
                            groupValue: discriminazione,
                            onChanged: ((value) {
                              setState(() {
                                discriminazione = value.toString();
                              });
                            }),
                          ),
                          RadioListTile(
                            title: const Text("Aggressione"),
                            value: "Aggressione",
                            groupValue: discriminazione,
                            onChanged: ((value) {
                              setState(() {
                                discriminazione = value.toString();
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title:
                        const Text("Vittima", style: ThemeText.titoloInoltro),
                    content: vittima_widget,
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text("Oppressore",
                        style: ThemeText.titoloInoltro),
                    content: Form(
                      child: Column(
                        children: <Widget>[
                          const Text(
                            "Scrivi qui il nome della persona e/o dell’organizzazione che Lei ritiene abbia compiuto l’azione discriminante",
                            style: ThemeText.corpoInoltro,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Nome oppressore'),
                            controller: oppressoreController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Per favore, inserisci il nome dell\'oppressore e/o organizzazione';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 3
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text(
                      "Vicenda",
                      style: ThemeText.titoloInoltro,
                    ),
                    content: Form(
                      child: Column(
                        children: <Widget>[
                          const Text(
                            "Includere tutti i dettagli specifici come nomi, date, orari, testimoni e qualsiasi altra informazione che potrebbe aiutarci nella nostra indagine in base alleSue affermazioni. Includere inoltre qualsiasi altra documentazione pertinente alla presente denuncia.",
                            style: ThemeText.corpoInoltro,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Scrivi qui la vicenda'),
                            controller: descrizioneController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Per favore, inserisci una descrizione';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 4
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text(
                      "Consenso",
                      style: ThemeText.titoloInoltro,
                    ),
                    content: consenso_widget,
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 5
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
          );
        }
      },
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    if (_formKey.currentState!.validate()) {
      _currentStep < 6 ? setState(() => _currentStep += 1) : null;
    }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  addRecord() async {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Inoltro denuncia in corso...')),
    // );
    DenunciaController control = DenunciaController();
    spidUtente = await control.retrieveSpidByUtente(utente);
    if (spidUtente != null) {
      Timestamp convertedDate =
          Timestamp.fromDate(spidUtente!.getDataScadenzaDocumento);

      var result = control.addDenunciaControl(
          nomeDenunciante: nameController.text,
          cognomeDenunciante: surnameController.text,
          indirizzoDenunciante: indirizzoController.text,
          capDenunciante: capController.text,
          provinciaDenunciante: provinciaController.text,
          cellulareDenunciante: numberController.text,
          emailDenunciante: emailController.text,
          tipoDocDenunciante: spidUtente!.tipoDocumento,
          numeroDocDenunciante: spidUtente!.numeroDocumento,
          scadenzaDocDenunciante: convertedDate,
          categoriaDenuncia: CategoriaDenuncia.values.byName(discriminazione!),
          nomeVittima: nomeVittimaController.text,
          denunciato: oppressoreController.text,
          descrizione: descrizioneController.text,
          cognomeVittima: cognomeVittimaController.text,
          consenso: consensoController,
          alreadyFiled: false);

      print(
          "Operation terminated with success on presentation layer, resultId: ");
    }
  }
}
