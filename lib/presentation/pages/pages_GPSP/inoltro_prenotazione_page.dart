import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:report_it/domain/entity/entity_GA/spid_entity.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/repository/authentication_controller.dart';
import 'package:report_it/domain/repository/prenotazione_controller.dart';
import '../../widget/styles.dart';

class InoltroPrenotazione extends StatefulWidget {
  final SuperUtente utente;
  final SPID spid;

  InoltroPrenotazione({required this.utente, required this.spid});
  @override
  _InoltroPrenotazione createState() =>
      _InoltroPrenotazione(utente: utente, spid: spid);
}

class _InoltroPrenotazione extends State<InoltroPrenotazione> {
  _InoltroPrenotazione({required this.utente, required this.spid});
  final SuperUtente utente;
  final SPID spid;
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController numberController;
  late TextEditingController indirizzoController = TextEditingController();
  late TextEditingController capController = TextEditingController();
  late TextEditingController provinciaController;
  late TextEditingController emailController;
  late TextEditingController cfController;
  late TextEditingController descrizioneController = TextEditingController();

  final regexEmail = RegExp(r"^[A-z0-9\.\+_-]+@[A-z0-9\._-]+\.[A-z]{2,6}$");
  final regexIndirizzo = RegExp(r"^[a-zA-Z+\s]+[,]?\s?[0-9]+$");
  final regexCap = RegExp(r"^[0-9]{5}$");
  final regexProvincia = RegExp(r"^[a-zA-Z]{2}$");
  final regexCellulare = RegExp(r"^((00|\+)39[\. ]??)??3\d{2}[\. ]??\d{6,7}$");
  final regexCF = RegExp(
      r"^([A-Z]{6}[0-9LMNPQRSTUV]{2}[ABCDEHLMPRST]{1}[0-9LMNPQRSTUV]{2}[A-Z]{1}[0-9LMNPQRSTUV]{3}[A-Z]{1})$|([0-9]{11})$");
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  String? discriminazione;
  String? consenso1, consenso2;
  FilePickerResult? impegnativaController;
  bool impegnativa = false;

  @override
  void initState() {
    nameController = TextEditingController(text: spid.nome);
    surnameController = TextEditingController(text: spid.cognome);
    numberController = TextEditingController(text: spid.numCellulare);
    provinciaController = TextEditingController(text: spid.provinciaNascita);
    emailController = TextEditingController(text: spid.indirizzoEmail);
    cfController = TextEditingController(text: spid.cf);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final consensoWidget = Flex(
      direction: Axis.vertical,
      children: [
        Column(
          children: <Widget>[
            const Text(
              "Acconsenti al trattamento dei dati da parte dell'Operatore CUP al fine di poter inserire i suoi dati personali all'interno del sistema. Acconsenti?",
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
                child: SizedBox(
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
                        "Bisogna necessariamente accettare il consenso per poter inoltrare correttamente la richiesta.",
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
            ? Flexible(
                flex: 0,
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            createRecord(utente);
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                                msg: "Inoltro avvenuto correttamente!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.grey.shade200,
                                textColor: Colors.black,
                                fontSize: 15.0);
                          }
                        },
                        style: ThemeText.bottoneRosso,
                        child: const Text(
                          "Inoltra",
                        ),
                      ),
                    )),
              )
            : Column(),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(219, 29, 69, 1),
        ),
        title:
            const Text("Supporto Psicologico", style: ThemeText.titoloSezione),
        elevation: 3,
        backgroundColor: ThemeText.theme.backgroundColor,
      ),
      body: Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(219, 29, 69, 1),
          ),
          backgroundColor: ThemeText.theme.backgroundColor,
        ),
        child: Stepper(
          controlsBuilder: (context, details) {
            if (_currentStep == 0) {
              return Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ThemeText.bottoneRosso,
                    child: const Text('Continua'),
                  ),
                ],
              );
            }
            if (_currentStep == 3) {
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
                      decoration: const InputDecoration(labelText: 'Nome'),
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Per favore, inserisci il nome.';
                        } else if (value.length < 2 || value.length > 30) {
                          return "Il nome inserito non è valido.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Cognome'),
                      controller: surnameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Per favore, inserisci il cognome.';
                        } else if (value.length < 2 || value.length > 30) {
                          return "Il cognome inserito non è valido.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Codice Fiscale'),
                      controller: cfController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Per favore, inserisci il tuo CF.';
                        } else if (!regexCF.hasMatch(value)) {
                          return 'Per favore, inserisci un CF valido.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Indirizzo'),
                      controller: indirizzoController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Per favore, inserisci un indirizzo';
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
                          return 'Per favore, inserisci un CAP valido';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Provincia'),
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
                      decoration:
                          const InputDecoration(labelText: 'Numero telefonico'),
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
                      decoration:
                          const InputDecoration(labelText: 'Indirizzo e-mail'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Per favore, inserisci l\'indirizzo e-mail.';
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
              state:
                  _currentStep >= 0 ? StepState.complete : StepState.disabled,
            ),
            Step(
              title: const Text(
                "Motivazione",
                style: ThemeText.titoloInoltro,
              ),
              content: Form(
                key: _formKey2,
                child: Column(
                  children: <Widget>[
                    const Text(
                      "Breve descrizione della motivazione per cui si sta richiedendo il consulto psicologico.",
                      style: ThemeText.corpoInoltro,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Scrivi qui la motivazione'),
                      controller: descrizioneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Per favore, inserisci il motivo della richiesta.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              isActive: _currentStep >= 0,
              state:
                  _currentStep >= 1 ? StepState.complete : StepState.disabled,
            ),
            Step(
              title: const Text("Impegnativa del medico",
                  style: ThemeText.titoloInoltro),
              content: Column(
                children: [
                  ElevatedButton(
                    style: ThemeText.bottoneRosso,
                    onPressed: (() {
                      impegnativa = true;
                      uploadImpegnativa();
                    }),
                    child: const Text("Carica l'impegnativa del medico"),
                  ),
                  impegnativa == true
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            impegnativaController == null
                                ? "Inserisci l'impegnativa"
                                : impegnativaController!.files.first.name,
                            style: impegnativaController == null
                                ? TextStyle(
                                    color: Color.fromRGBO(219, 29, 69, 1))
                                : TextStyle(color: Colors.black),
                          ),
                        )
                      : Container(),
                ],
              ),
              isActive: _currentStep >= 0,
              state:
                  _currentStep >= 2 ? StepState.complete : StepState.disabled,
            ),
            Step(
              title: const Text(
                "Consenso",
                style: ThemeText.titoloInoltro,
              ),
              content: consensoWidget,
              isActive: _currentStep >= 0,
              state:
                  _currentStep >= 3 ? StepState.complete : StepState.disabled,
            ),
          ],
        ),
      ),
      backgroundColor: ThemeText.theme.backgroundColor,
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
    if (_currentStep == 0) {
      if (_formKey.currentState!.validate()) {
        _currentStep < 6 ? setState(() => _currentStep += 1) : null;
      }
    } else if (_currentStep == 1) {
      if (_formKey2.currentState!.validate()) {
        print("ciao");
        _currentStep < 6 ? setState(() => _currentStep += 1) : null;
      }
    } else if (_currentStep == 2) {
      if (impegnativaController == null) {
        impegnativa = !impegnativa;
        setState(() {});
      } else {
        _currentStep < 6 ? setState(() => _currentStep += 1) : null;
      }
    } else {
      if (_formKey.currentState!.validate()) {
        _currentStep < 6 ? setState(() => _currentStep += 1) : null;
      }
    }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  Future<void> uploadImpegnativa() async {
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf'], withData: true);
    if (fileResult != null) {
      impegnativaController = fileResult;
    }
    setState(() {});
  }

  void createRecord(SuperUtente utente) async {
    PrenotazioneController prenotazioneControl = PrenotazioneController();
    if (impegnativaController != null) {
      var result = prenotazioneControl.addPrenotazioneControl(
          nome: nameController.text,
          cognome: surnameController.text,
          numeroTelefono: numberController.text,
          indirizzo: indirizzoController.text,
          cap: capController.text,
          provincia: provinciaController.text,
          email: emailController.text,
          cf: cfController.text,
          impegnativa: impegnativaController!,
          descrizione: descrizioneController.text);
      print(await result);
    }
  }
}
