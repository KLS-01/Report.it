import 'package:flutter/material.dart';

class InoltroDenuncia extends StatefulWidget {
  @override
  _InoltroDenuncia createState() => _InoltroDenuncia();
}

class _InoltroDenuncia extends State<InoltroDenuncia> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final regexEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String? discriminazione;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromRGBO(219, 29, 69, 1),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Stepper(
        controlsBuilder: (context, details) {
          return Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: details.onStepContinue,
                child: Text('Continua'),
              ),
              TextButton(
                onPressed: details.onStepCancel,
                child: Text(
                  'Indietro',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          );
        },
        type: stepperType,
        currentStep: _currentStep,
        // onStepTapped: (step) => tapped(step), <- se lo si abilita, l'utente sarà abilitato a viaggiare tra le sezioni
        onStepContinue: continued,
        onStepCancel: cancel,
        steps: <Step>[
          Step(
            title: Text("Dati anagrafici"),
            content: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Per favore, inserisci il nome';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Cognome'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Per favore, inserisci il cognome';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: 'Numero telefonico'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Per favore, inserisci il numero telefonico';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Indirizzo e-mail'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Per favore, inserisci l\'indirizzo e-mail';
                      } else if (!regexEmail.hasMatch(value!)) {
                        return 'Per favore, inserisci una e-mail valida';
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
            title: Text("Discriminazione"),
            content: Form(
              key: _formKey2,
              child: Column(
                children: <Widget>[
                  Text(
                    "Indicare la natura della presunta discriminazione:",
                    style: TextStyle(fontSize: 16),
                  ),
                  RadioListTile(
                    title: Text("Razza"),
                    value: "Razza",
                    groupValue: discriminazione,
                    onChanged: ((value) {
                      setState(() {
                        discriminazione = value.toString();
                      });
                    }),
                  ),
                  RadioListTile(
                    title: Text("Colore"),
                    value: "Colore",
                    groupValue: discriminazione,
                    onChanged: ((value) {
                      setState(() {
                        discriminazione = value.toString();
                      });
                    }),
                  ),
                  RadioListTile(
                    title: Text("Origine Nazionale"),
                    value: "OrigineNazionale",
                    groupValue: discriminazione,
                    onChanged: ((value) {
                      setState(() {
                        discriminazione = value.toString();
                      });
                    }),
                  ),
                  RadioListTile(
                    title: Text("Disabilità"),
                    value: "Disabilita",
                    groupValue: discriminazione,
                    onChanged: ((value) {
                      setState(() {
                        discriminazione = value.toString();
                      });
                    }),
                  ),
                  RadioListTile(
                    title: Text("Età"),
                    value: "Eta",
                    groupValue: discriminazione,
                    onChanged: ((value) {
                      setState(() {
                        discriminazione = value.toString();
                      });
                    }),
                  ),
                  RadioListTile(
                    title: Text("Sesso"),
                    value: "Sesso",
                    groupValue: discriminazione,
                    onChanged: ((value) {
                      setState(() {
                        discriminazione = value.toString();
                      });
                    }),
                  ),
                  RadioListTile(
                    title: Text("Orientamento Sessuale"),
                    value: "OrientamentoSessuale",
                    groupValue: discriminazione,
                    onChanged: ((value) {
                      setState(() {
                        discriminazione = value.toString();
                      });
                    }),
                  ),
                  RadioListTile(
                    title: Text("Religione"),
                    value: "Religione",
                    groupValue: discriminazione,
                    onChanged: ((value) {
                      setState(() {
                        discriminazione = value.toString();
                      });
                    }),
                  ),
                  RadioListTile(
                    title: Text("Stirpe"),
                    value: "Stirpe",
                    groupValue: discriminazione,
                    onChanged: ((value) {
                      setState(() {
                        discriminazione = value.toString();
                      });
                    }),
                  ),
                  RadioListTile(
                    title: Text("Gender"),
                    value: "Gender",
                    groupValue: discriminazione,
                    onChanged: ((value) {
                      setState(() {
                        discriminazione = value.toString();
                      });
                    }),
                  ),
                  RadioListTile(
                    title: Text("Etnicità"),
                    value: "Etnicita",
                    groupValue: discriminazione,
                    onChanged: ((value) {
                      setState(() {
                        discriminazione = value.toString();
                      });
                    }),
                  ),
                  RadioListTile(
                    title: Text("Identità di genere"),
                    value: "IdentitaDiGenere",
                    groupValue: discriminazione,
                    onChanged: ((value) {
                      setState(() {
                        discriminazione = value.toString();
                      });
                    }),
                  ),
                  RadioListTile(
                    title: Text("Espressione di genere"),
                    value: "EspressioneDiGenere",
                    groupValue: discriminazione,
                    onChanged: ((value) {
                      setState(() {
                        discriminazione = value.toString();
                      });
                    }),
                  ),
                  RadioListTile(
                    title: Text("Fede religiosa"),
                    value: "Fede",
                    groupValue: discriminazione,
                    onChanged: ((value) {
                      setState(() {
                        discriminazione = value.toString();
                      });
                    }),
                  ),
                  RadioListTile(
                    title: Text("Veterano"),
                    value: "Veterano",
                    groupValue: discriminazione,
                    onChanged: ((value) {
                      setState(() {
                        discriminazione = value.toString();
                      });
                    }),
                  ),
                  RadioListTile(
                    title: Text("Storia Personale"),
                    value: "StoriaPersonale",
                    groupValue: discriminazione,
                    onChanged: ((value) {
                      setState(() {
                        discriminazione = value.toString();
                      });
                    }),
                  ),
                  RadioListTile(
                    title: Text("Reddito"),
                    value: "BassoReddito",
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
            state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: Text("Vittima"),
            content: Form(
              child: Column(
                children: <Widget>[
                  Text(
                    "Indicare la natura della presunta discriminazione:",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            isActive: _currentStep >= 0,
            state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
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
      _currentStep < 4 ? setState(() => _currentStep += 1) : null;
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
