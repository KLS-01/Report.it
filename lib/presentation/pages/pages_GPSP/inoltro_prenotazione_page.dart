import 'package:flutter/material.dart';

class InoltroPrenotazione extends StatefulWidget {
  @override
  _InoltroPrenotazione createState() => _InoltroPrenotazione();
}

class _InoltroPrenotazione extends State<InoltroPrenotazione> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController indirizzoController = TextEditingController();
  final TextEditingController capController = TextEditingController();
  final TextEditingController provinciaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

// aggiungere controllo sul CF

  final regexEmail = RegExp(r"^[A-z0-9\.\+_-]+@[A-z0-9\._-]+\.[A-z]{2,6}$");
  final regexIndirizzo = RegExp(r"^[a-zA-Z+\s]+[,]\s?[0-9]$");
  final regexCap = RegExp(r"^[0-9]{5}$");
  final regexProvincia = RegExp(r"^[a-zA-Z]{2}$");
  final regexCellulare = RegExp(r"^((00|\+)39[\. ]??)??3\d{2}[\. ]??\d{6,7}$");

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String? discriminazione;
  String? consenso1, consenso2;

  @override
  Widget build(BuildContext context) {
    final consensoWidget = Wrap(
      children: [
        Column(
          children: <Widget>[
            const Text(
              "Acconsenti al trattamento dei dati da parte dell'OperatoreCUP al fine di poter inserire i suoi dati personali all'interno del sistema. Acconsenti?",
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
                            color: Color.fromRGBO(219, 29, 69, 1),
                          )),
                    ),
                    Text(
                      "Bisogna necessariamente accettare il consenso per poter inoltra correttamente la richiesta.",
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(219, 29, 69, 1),
        ),
        title: const Text(
          "Prenotazione Psicologica",
          style: TextStyle(
            fontFamily: 'SourceSerifPro',
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        elevation: 3,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Stepper(
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
                fontFamily: 'SourceSerifPro',
                fontWeight: FontWeight.bold,
              ),
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
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Codice Fiscale'),
                    // controller: mettere controller del CF,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Per favore, inserisci il tuo CF.';
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
            state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: const Text(
              "Motivazione",
              style: TextStyle(
                fontFamily: 'SourceSerifPro',
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Form(
              child: Column(
                children: <Widget>[
                  const Text(
                    "Breve descrizione della motivazione per cui si sta richiedendo il consulto psicologico.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Scrivi qui la motivazione'),
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
            state: _currentStep >= 4 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: const Text(
              "Consenso",
              style: TextStyle(
                fontFamily: 'SourceSerifPro',
                fontWeight: FontWeight.bold,
              ),
            ),
            content: consensoWidget,
            isActive: _currentStep >= 0,
            state: _currentStep >= 5 ? StepState.complete : StepState.disabled,
          ),
        ],
      ),
      //backgroundColor: Theme.of(context).backgroundColor,
      backgroundColor: Colors.white,
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
