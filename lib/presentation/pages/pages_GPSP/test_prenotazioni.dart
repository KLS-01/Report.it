import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/data/models/prenotazione_dao.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/domain/repository/prenotazione_controller.dart';
import 'package:report_it/firebase_options.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(PrenotazionePage());
}

class PrenotazionePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Prenotazioni demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomPage(),
      ),
    );
  }
}

class MyCustomPage extends StatefulWidget {
  late final SuperUtente utente;
  @override
  MyCustomPageState createState() {
    return MyCustomPageState(utente: utente);
  }
}

class MyCustomPageState extends State<MyCustomPage> {
  MyCustomPageState({required this.utente});
  final _formKey = GlobalKey<FormState>();
  final SuperUtente utente;
  final TextEditingController capController =
      TextEditingController(text: "525698");
  final TextEditingController provinciaController =
      TextEditingController(text: "BN");

  @override
  Widget build(BuildContext context) {
    return Consumer<SuperUtente?>(
      builder: (context, utente, child) {
        if (utente == null) {
          return const Text("Errore, non sei loggato");
        } else if ((utente.tipo != TipoUtente.Utente)) {
          return const Text("Errore, non sei autorizzato");
        } else {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: '',
                      labelText: 'CAP',
                    ),
                    controller: capController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Per favore, inserisci il CAP!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.phone),
                      hintText: '',
                      labelText: 'Provincia',
                    ),
                    controller: provinciaController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Per favore, inserisci la provincia!';
                      }
                      return null;
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
                          createRecord(utente);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop(context);
                        },
                        child: const Text('Mostra prenotazione'),
                      ))
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void createRecord(SuperUtente? utente) async {
    PrenotazioneController control = PrenotazioneController();

    FilePickerResult? fileResult = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf'], withData: true);
    if (fileResult != null) {
      var result = control.addPrenotazioneControl(
          utente: utente,
          cap: capController.text,
          provincia: provinciaController.text,
          impegnativa: fileResult);
    } else {
      print("Null file");
    }
  }

  void showPrenotazione(SuperUtente? utente) async {
    PrenotazioneController control = PrenotazioneController();
    print(await control.visualizzaAttiveByUtente(utente));
  }
}
