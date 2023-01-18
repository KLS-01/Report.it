import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:report_it/domain/entity/entity_GD/categoria_denuncia.dart';
import 'package:report_it/domain/repository/denuncia_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Flutter Form Demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nomeDenuncianteController =
      TextEditingController(text: "Tizio");
  final TextEditingController cognomeDenuncianteController =
      TextEditingController(text: "Caio");
  final TextEditingController indirizzoDenuncianteController =
      TextEditingController(text: "Via Roma 23");
  final TextEditingController capDenuncianteController =
      TextEditingController(text: "85896");
  final TextEditingController provinciaDenuncianteController =
      TextEditingController(text: "BN");
  final TextEditingController cellulareDenuncianteController =
      TextEditingController(text: "3256987");
  final TextEditingController emailDenuncianteController =
      TextEditingController(text: "email@email.com");
  final TextEditingController tipoDocDenuncianteController =
      TextEditingController(text: "Carta dientità");
  final TextEditingController numDocDenuncianteController =
      TextEditingController(text: "AA4589");
  final TextEditingController scadDocDenuncianteController =
      TextEditingController(text: "2026-03-20 00:00:00.000");
  final TextEditingController categoriaController =
      TextEditingController(text: "Razza");
  final TextEditingController nomeVittimaController =
      TextEditingController(text: "Tizio");
  final TextEditingController cognomeVittimaController =
      TextEditingController(text: "Caio");
  final TextEditingController denunciatoController =
      TextEditingController(text: "Cattivo");
  final TextEditingController descrizioneController =
      TextEditingController(text: "Insulti ecc ecc");
  bool? consensoValue = false, alreadyFilledValue = false;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: '',
              labelText: 'Nome denunciante',
            ),
            controller: nomeDenuncianteController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Per favore, inserisci il nome!';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.phone),
              hintText: '',
              labelText: 'Cognome denunciante',
            ),
            controller: cognomeDenuncianteController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Per favore, inserisci il cognome!';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: '',
              labelText: 'IndirizzoDenunciante',
            ),
            controller: indirizzoDenuncianteController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Per favore, inserisci l'indirizzo!";
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: '',
              labelText: 'Cap denunciante',
            ),
            controller: capDenuncianteController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Per favore, inserisci il CAP!';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: '',
              labelText: 'Provincia denunciante',
            ),
            controller: provinciaDenuncianteController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Per favore, inserisci la provincia!';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: '',
              labelText: 'Cellulare denunciante',
            ),
            controller: cellulareDenuncianteController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Per favore, inserisci il cellulare!';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: '',
              labelText: 'Email denunciante',
            ),
            controller: emailDenuncianteController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Per favore, inserisci la mail!';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: '',
              labelText: 'Tipo doc denunciante',
            ),
            controller: tipoDocDenuncianteController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Per favore, inserisci il tipo documento!';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: '',
              labelText: 'Numero doc denunciante',
            ),
            controller: numDocDenuncianteController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Per favore, inserisci numero del documento!';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: '',
              labelText: 'Scadenza doc denunciante',
            ),
            controller: scadDocDenuncianteController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Per favore, inserisci la scadenza del documento!';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: '',
              labelText: 'Categoria denuncia',
            ),
            controller: categoriaController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Per favore, inserisci la categoria!';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: '',
              labelText: 'Nome vittima',
            ),
            controller: nomeVittimaController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Per favore, inserisci il nome!';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: '',
              labelText: 'Cognome vittima',
            ),
            controller: cognomeVittimaController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Per favore, inserisci il cognome!';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: '',
              labelText: 'Denunciato',
            ),
            controller: denunciatoController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Per favore, inserisci il nome del denunciato!';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: '',
              labelText: 'Descrizione',
            ),
            controller: descrizioneController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Per favore, inserisci la descrizione!';
              }
              return null;
            },
          ),
          FormField<bool>(
            builder: (state) {
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                          value: consensoValue,
                          onChanged: (value) {
                            setState(() {
//save checkbox value to variable that store terms and notify form that state changed
                              consensoValue = value;
                              state.didChange(value);
                            });
                          }),
                      Text('Consenso'),
                    ],
                  ),
//display error in matching theme
                  Text(
                    state.errorText ?? '',
                    style: TextStyle(
                      color: Theme.of(context).errorColor,
                    ),
                  )
                ],
              );
            },
//output from validation will be displayed in state.errorText (above)
            validator: (value) {
              if (consensoValue == null) {
                return 'Error';
              } else if (!consensoValue!) {
                return 'You need to accept terms';
              } else {
                return null;
              }
            },
          ),
          FormField<bool>(
            builder: (state) {
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                          value: alreadyFilledValue,
                          onChanged: (value) {
                            setState(() {
//save checkbox value to variable that store terms and notify form that state changed
                              alreadyFilledValue = value;
                              state.didChange(value);
                            });
                          }),
                      Text('Already filed'),
                    ],
                  ),
//display error in matching theme
                  Text(
                    state.errorText ?? '',
                    style: TextStyle(
                      color: Theme.of(context).errorColor,
                    ),
                  )
                ],
              );
            },
//output from validation will be displayed in state.errorText (above)
            validator: (value) {
              if (alreadyFilledValue == null) {
                return 'Error';
              } else {
                return null;
              }
            },
          ),
          Container(
            padding: const EdgeInsets.only(left: 150.0, top: 40.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  //testMethod();
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      )),
    );
  }

  // testMethod() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Processing Data')),
  //   );

  //   Timestamp convertedDate =
  //       Timestamp.fromDate(DateTime.parse(scadDocDenuncianteController.text));
  //   DenunciaController control = DenunciaController();
  //   var result = control.addDenunciaControl(
  //       nomeDenunciante: nomeDenuncianteController.text,
  //       cognomeDenunciante: cognomeDenuncianteController.text,
  //       indirizzoDenunciante: indirizzoDenuncianteController.text,
  //       capDenunciante: capDenuncianteController.text,
  //       provinciaDenunciante: provinciaDenuncianteController.text,
  //       cellulareDenunciante: cellulareDenuncianteController.text,
  //       emailDenunciante: emailDenuncianteController.text,
  //       tipoDocDenunciante: tipoDocDenuncianteController.text,
  //       numeroDocDenunciante: nomeDenuncianteController.text,
  //       scadenzaDocDenunciante: convertedDate,
  //       categoriaDenuncia:
  //           CategoriaDenuncia.values.byName(categoriaController.text),
  //       nomeVittima: nomeVittimaController.text,
  //       denunciato: denunciatoController.text,
  //       descrizione: descrizioneController.text,
  //       cognomeVittima: cognomeVittimaController.text,
  //       consenso: consensoValue!,
  //       alreadyFilled: alreadyFilledValue!);

  //   print(
  //       "Operation terminated with success on presentation layer, resultId: $result");
  // }
}
