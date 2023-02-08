import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:report_it/application/entity/entity_GPSP/prenotazione_entity.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

import 'package:report_it/application/entity/entity_GA/super_utente.dart';
import 'package:report_it/application/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/application/repository/prenotazione_controller.dart';
import 'package:report_it/presentation/widget/styles.dart';

class InformazioniPrenotazione extends StatefulWidget {
  final String idPrenotazione;
  final SuperUtente utente;

  const InformazioniPrenotazione({
    Key? key,
    required this.idPrenotazione,
    required this.utente,
  }) : super(key: key);

  @override
  State<InformazioniPrenotazione> createState() =>
      _InformazioniPrenotazione(idPrenotazione: idPrenotazione, utente: utente);
}

@override
initState() {}

class _InformazioniPrenotazione extends State<InformazioniPrenotazione> {
  late String idPrenotazione;
  late SuperUtente utente;
  final _prenotazioneFormKey = GlobalKey<FormState>();
  var dateController;
  final TextEditingController timeController =
      TextEditingController(text: "08:00");

  final TextEditingController psicologoController = TextEditingController();
  var formatter = DateFormat('dd-MM-yyyy HH:mm');
  _InformazioniPrenotazione({
    required this.idPrenotazione,
    required this.utente,
  });
  late Prenotazione prenotazione;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Prenotazione>(
      future: retrievePrenotazione(idPrenotazione),
      builder: (BuildContext context, AsyncSnapshot<Prenotazione> snapshot) {
        if (!snapshot.hasData) {
          // while data is loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // data loaded:
          if (snapshot.data != null) {
            prenotazione = snapshot.data!;
          } else {
            return const Text("Error");
          }
          return Scaffold(
              appBar: AppBar(
                title: const Text('Dettagli prenotazione',
                    style: ThemeText.titoloSezione),
                backgroundColor: Theme.of(context).backgroundColor,
                iconTheme: const IconThemeData(
                  color: Color.fromRGBO(219, 29, 69, 1),
                ),
              ),
              backgroundColor: Theme.of(context).backgroundColor,
              body: SingleChildScrollView(
                  child: Column(children: [
                Container(
                  decoration: ThemeText.boxDettaglio,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Dati del paziente',
                      labelStyle: ThemeText.titoloDettaglio,
                      border: InputBorder.none,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "ID Prenotazione: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: "${prenotazione.getId}",
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
                            text: "Nome: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: "${prenotazione.getNomeUtente}",
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
                                text: "${prenotazione.getCognomeUtente}",
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
                            text: "Recapito: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: "${prenotazione.getNumeroUtente}",
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
                                text: "${prenotazione.getEmailUtente}",
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
                            text: "CF: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: "${prenotazione.getCfUtente}",
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
                                text: "${prenotazione.getIndirizzoUtente}",
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
                                text: "${prenotazione.getProvincia}",
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
                                text: "${prenotazione.getCap}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      appBar: AppBar(
                                        iconTheme: const IconThemeData(
                                          color: Color.fromRGBO(219, 29, 69, 1),
                                        ),
                                        backgroundColor:
                                            Theme.of(context).backgroundColor,
                                        title: const Text(
                                          'Impegnativa',
                                          style: ThemeText.titoloSezione,
                                        ),
                                      ),
                                      body: SfPdfViewer.network(
                                        prenotazione.getImpegnativa,
                                      ),
                                    ),
                                  ),
                                ),
                              },
                              style: ThemeText.bottoneRosso,
                              child: const Text("Visualizza impegnativa"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: ThemeText.boxDettaglio,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Motivazione',
                      labelStyle: ThemeText.titoloDettaglio,
                      border: InputBorder.none,
                    ),
                    child: Text(
                      prenotazione.descrizione,
                    ),
                  ),
                ),

                //* -------------------------------------QUA INIZIA IL SECONDO----------------------------------------------------

                if (utente.tipo == TipoUtente.OperatoreCup &&
                    prenotazione.getDataPrenotazione == null)
                  Container(
                    decoration: ThemeText.boxDettaglio,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Lato Operatore CUP',
                        labelStyle: ThemeText.titoloDettaglio,
                        border: InputBorder.none,
                      ),
                      child: Form(
                          key: _prenotazioneFormKey,
                          child: SingleChildScrollView(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Builder(builder: (context) {
                                DateTime initDate =
                                    DateTime.now().add(const Duration(days: 1));
                                print(initDate.weekday);
                                while (initDate.weekday > 5) {
                                  initDate =
                                      initDate.add(const Duration(days: 1));
                                }
                                var tempFormatter = DateFormat('yyyy-MM-dd');
                                dateController =
                                    tempFormatter.format(initDate).toString();
                                print(initDate.weekday);
                                return DateTimePicker(
                                  type: DateTimePickerType.date,
                                  dateMask: 'd MMM, yyyy',
                                  initialValue: initDate.toString(),
                                  firstDate: DateTime.now()
                                      .add(const Duration(days: 1)),
                                  lastDate: DateTime(2100),
                                  icon: const Icon(Icons.event,
                                      color: Color.fromRGBO(219, 29, 69, 1)),
                                  dateLabelText: 'Date',
                                  locale: const Locale('it', 'IT'),
                                  selectableDayPredicate: (date) {
                                    if (date.weekday == 6 ||
                                        date.weekday == 7) {
                                      return false;
                                    }
                                    return true;
                                  },
                                  onChanged: (val) => dateController = val,
                                  onSaved: (val) => dateController = val,
                                );
                              }),
                              Builder(builder: (context) {
                                return TextFormField(
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.access_time,
                                          color:
                                              Color.fromRGBO(219, 29, 69, 1)),
                                      hintText: '',
                                      labelText: 'Ora appuntamento',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Per favore, inserisci l'ora dell'appuntamento!";
                                      }
                                      return null;
                                    },
                                    enableInteractiveSelection: false,
                                    showCursor: false,
                                    controller: timeController,
                                    keyboardType: TextInputType.none,
                                    onTap: test);
                              }),
                              TextFormField(
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.psychology_outlined,
                                        color: Color.fromRGBO(219, 29, 69, 1)),
                                    hintText: '',
                                    labelText: 'Nome psicologo',
                                  ),
                                  controller: psicologoController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Per favore, inserisci il nome dello psicologo!";
                                    }
                                    return null;
                                  }),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      style: ThemeText.bottoneRosso,
                                      onPressed: () {
                                        if (_prenotazioneFormKey.currentState!
                                            .validate()) {
                                          inizializza(dateController,
                                              timeController.text);

                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Inoltro avvenuto correttamente!",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 2,
                                              backgroundColor:
                                                  Colors.grey.shade200,
                                              textColor: Colors.black,
                                              fontSize: 15.0);
                                        }
                                      },
                                      child: const Text(
                                          'Inizializza prenotazione'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ))),
                    ),
                  )
                else if (prenotazione.getDataPrenotazione != null)
                  Container(
                    decoration: ThemeText.boxDettaglio,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: "Orario e data della visita",
                        labelStyle: ThemeText.titoloDettaglio,
                        border: InputBorder.none,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Nome psicologo: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: "${prenotazione.getPsicologo}",
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
                              text: "Data appuntamento: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      "${formatter.format(DateTime.parse(prenotazione.getDataPrenotazione.toDate().toString()))}",
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
                  )
              ])));
        }
      },
    );
  }

  void inizializza(String date, time) {
    var parsedDate = DateTime.parse("$date $time");
    Timestamp ts = Timestamp.fromDate(parsedDate);
    PrenotazioneController control = PrenotazioneController();
    control.inizializzaPrenotazione(
        prenotazione.getId, utente, ts, psicologoController.text);
  }

  void test() async {
    // ignore: unused_local_variable
    var timeSelected;

    var time = showCustomTimePicker(
            context: context,

            // It is a must if you provide selectableTimePredicate
            onFailValidation: (context) => print('Unavailable selection'),
            initialTime: TimeOfDay(hour: 8, minute: 0),
            selectableTimePredicate: (time) =>
                time!.hour > 7 && time.hour < 20 && time.minute % 5 == 0)
        .then((time) => timeSelected = time?.format(context));
    if (await time != null) {
      timeController.text = (await time)!;
    }
    print(timeController.text);
  }

  Future<Prenotazione> retrievePrenotazione(String? idPrenotazione) async {
    PrenotazioneController control = PrenotazioneController();
    Prenotazione? temp;
    if (idPrenotazione != null) {
      temp = await control.retrieveById(idPrenotazione);
    }

    if (temp != null) {
      prenotazione = temp;
      print("prenotazione not null");
    }
    return temp!;
  }
}
