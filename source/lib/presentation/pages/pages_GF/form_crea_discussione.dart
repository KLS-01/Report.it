import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/application/entity/entity_GA/super_utente.dart';
import 'package:report_it/application/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/application/repository/forum_controller.dart';
import 'package:report_it/presentation/widget/styles.dart';
import 'package:report_it/presentation/widget/theme.dart';
import 'package:file_picker/file_picker.dart';

class ForumForm extends StatefulWidget {
  const ForumForm({super.key});

  @override
  State<ForumForm> createState() => _ForumFormState();
}

class _ForumFormState extends State<ForumForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titoloController = TextEditingController();
  final TextEditingController testoController = TextEditingController();
  FilePickerResult? fileResult;

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Consumer<SuperUtente?>(
      builder: ((context, utente, child) {
        return Scaffold(
          backgroundColor: AppTheme().build()!.backgroundColor,
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Color.fromRGBO(219, 29, 69, 1),
            ),
            title: const Text(
              "Apri una discussione",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            elevation: 3,
            backgroundColor: ThemeText.theme.backgroundColor,
          ),
          body: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.04, 0, 0, 0),
                      child: const Text(
                        "Titolo",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: titoloController,
                        decoration: InputDecoration(
                          hintText: "Inserisci un titolo",
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)),
                          contentPadding: const EdgeInsets.all(20.0),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Per favore, inserisci un titolo';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.04, 0, 0, 0),
                      child: const Text(
                        "Testo della discussione",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: testoController,
                        decoration: InputDecoration(
                          hintText: "Scrivi il testo della tua discussione...",
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)),
                          contentPadding: const EdgeInsets.all(20.0),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Per favore, inserisci un titolo';
                          }
                          return null;
                        },
                        maxLines: 10,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5),
                            textStyle: MaterialStateProperty.all(
                                Theme.of(context).textTheme.button),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              ThemeText.theme.primaryColor,
                            ),
                          ),
                          onPressed: (() async {
                            fileResult = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'png'],
                              withData: true,
                            );
                          }),
                          child: Text("Carica un immagine")),
                    )
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: Visibility(
            visible: !keyboardIsOpen,
            child: FloatingActionButton.extended(
              label: Text('Pubblica'),
              heroTag: null,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (fileResult != null) {
                    if (utente!.tipo == TipoUtente.Utente) {
                      ForumService().ApriDiscussione(titoloController.text,
                          testoController.text, fileResult!);
                    } else if (utente.tipo == TipoUtente.UffPolGiud) {
                      ForumService().AggiungiDiscussioneUFF(
                          titoloController.text,
                          testoController.text,
                          fileResult!);
                    } else {
                      ForumService().AggiungiDiscussioneCUP(
                          titoloController.text,
                          testoController.text,
                          fileResult!);
                    }
                    Navigator.pop(context);
                  } else {
                    if (utente!.tipo == TipoUtente.Utente) {
                      ForumService().ApriDiscussione(
                          titoloController.text, testoController.text);
                    } else if (utente.tipo == TipoUtente.UffPolGiud) {
                      ForumService().AggiungiDiscussioneUFF(
                        titoloController.text,
                        testoController.text,
                      );
                    } else {
                      ForumService().AggiungiDiscussioneCUP(
                        titoloController.text,
                        testoController.text,
                      );
                    }
                    Navigator.pop(context);
                  }
                }
              },
              backgroundColor: const Color.fromRGBO(219, 29, 69, 1),
            ),
          ),
        );
      }),
    );
  }
}
