import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/tipo_utente.dart';

import '../../domain/entity/super_utente.dart';

class DettagliDenuncia extends StatefulWidget {
  @override
  _DettagliDenuncia createState() => _DettagliDenuncia();
}

class _DettagliDenuncia extends State<DettagliDenuncia> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController indirizzoController = TextEditingController();
  final TextEditingController capController = TextEditingController();
  final TextEditingController provinciaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController oppressoreController = TextEditingController();

  final TextEditingController nomeVittimaController = TextEditingController();
  final TextEditingController cognomeVittimaController =
      TextEditingController();
  final regexEmail = RegExp(r"^[A-z0-9\.\+_-]+@[A-z0-9\._-]+\.[A-z]{2,6}$");
  //   r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final regexIndirizzo = RegExp(r"^[a-zA-Z+\s]+[,+\s][0-9]$");
  final regexCap = RegExp(r"^[0-9]{5}$");
  final regexProvincia = RegExp(r"^[a-zA-Z]{2}$");
  final regexCellulare = RegExp(r"^((00|\+)39[\. ]??)??3\d{2}[\. ]??\d{6,7}$");

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String? discriminazione;
  String? vittima1, vittima2;
  String? consenso1, consenso2;

  @override
  Widget build(BuildContext context) {
    final consenso_widget = Wrap(
      children: [
        Column(
          children: <Widget>[
            const Text(
              "Rilascia il consenso all'Ufficiale di Polizia Giudiziaria di condividere il Suo nome ed altre informazioni personali con altre parti inerenti a questo caso quando così facendo si collabora nell’investigazione e nella risoluzione del Suo reclamo?",
              style: TextStyle(fontSize: 16),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Attenzione!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          )),
                    ),
                    Text(
                      "Bisogna necessariamente accettare il consenso per poter inoltra correttamente tale denuncia.",
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            : Column(),
        //se il consenso "sì" --> allora il bottne viene mostrato
        (consenso1) != null
            ? Flexible(
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          //
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text(
                          "Inoltra",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )),
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
              style: TextStyle(fontSize: 16),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 5),
                    const Text(
                      "Scrivi qui il nome della presunta vittima: ",
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
              iconTheme: const IconThemeData(
                color: Color.fromRGBO(219, 29, 69, 1),
              ),
              title: const Text(
                "Modulo inoltro denuncia/querela",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              elevation: 3,
              backgroundColor: Theme.of(context).backgroundColor,
            ),
            body: Theme(
              data: ThemeData(
                colorScheme: ColorScheme.light(
                  primary: Color.fromRGBO(219, 29, 69, 1),
                ),
              ),
              child: Stepper(
                controlsBuilder: (context, details) {
                  if (_currentStep == 0) {
                    return Row(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: details.onStepContinue,
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Nome'),
                          Text('Cognome'),
                          Text('Indirizzo'),
                          Text('CAP'),
                          Text('Provincia'),
                          Text('Numero telefonico'),
                          Text('Indirizzo e-mail'),
                        ],
                      ),
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text(
                      "Discriminazione",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Form(
                      key: _formKey2,
                      child: Column(
                        children: <Widget>[
                          const Text(
                            "La natura della presunta discriminazione è:",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.start,
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
                    title: const Text(
                      "Vittima",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      'La vittima di discriminazione è:',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text(
                      "Oppressore",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Form(
                      child: Column(
                        children: <Widget>[
                          const Text(
                            "Persona e/o organizzazione che ha compiuto l'azione discriminante: ",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Nome oppressore')
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Form(
                      child: Column(
                        children: <Widget>[
                          const Text(
                            'Dettagli',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 20,
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
                      "Consenso",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      'Consenso',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
            //backgroundColor: Theme.of(context).backgroundColor,
            backgroundColor: Colors.white,
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
}
