import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/domain/entity/entity_GPSP/prenotazione_entity.dart';

import 'package:report_it/domain/repository/prenotazione_controller.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

class InformazioniPrenotazione extends StatefulWidget {
  final Prenotazione prenotazione;
  final SuperUtente utente;

  const InformazioniPrenotazione({
    Key? key,
    required this.prenotazione,
    required this.utente,
  }) : super(key: key);

  @override
  State<InformazioniPrenotazione> createState() =>
      _InformazioniPrenotazione(prenotazione: prenotazione, utente: utente);
}

@override
initState() {}

class _InformazioniPrenotazione extends State<InformazioniPrenotazione> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  late Prenotazione prenotazione;
  late SuperUtente utente;
  final _prenotazioneFormKey = GlobalKey<FormState>();
  var dateController;
  final TextEditingController timeController =
      TextEditingController(text: "08:00");

  _InformazioniPrenotazione({
    required this.prenotazione,
    required this.utente,
  });
  @override
  Widget build(BuildContext context) {
    print(prenotazione.getDataPrenotazione);
    return Scaffold(
        body: Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 10),
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Torna indietro")),
      ),
      Padding(
          padding: const EdgeInsets.all(50),
          child: Column(children: [
            SingleChildScrollView(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      "Info prenotazione",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0,
                      ),
                    ),
                    const Text("IDPrenotazione"),
                    Text(prenotazione.getId),
                    const Text("IDUtente"),
                    Text(prenotazione.getIdUtente),
                    const Text("Provincia"),
                    Text(prenotazione.getProvincia),
                    const Text("CAP"),
                    Text(prenotazione.getCap),
                    const Text("Impegnativa"),
                    ElevatedButton(
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Scaffold(
                                          appBar: AppBar(
                                              title: const Text('Impegnativa'),
                                              actions: <Widget>[
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.first_page,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    _pdfViewerController
                                                        .firstPage();
                                                  },
                                                )
                                              ]),
                                          body: SfPdfViewer.network(
                                            prenotazione.getImpegnativa,
                                          ))))
                            },
                        child: const Text("Visualizza impegnativa")),
                    if (utente.tipo == TipoUtente.OperatoreCup &&
                        prenotazione.getDataPrenotazione == null)
                      Form(
                          key: _prenotazioneFormKey,
                          child: SingleChildScrollView(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Builder(builder: (context) {
                                DateTime initDate = DateTime.now();
                                print(initDate.weekday);
                                while (initDate.weekday > 5) {
                                  initDate =
                                      initDate.add(const Duration(days: 1));
                                }
                                print(initDate.weekday);
                                return DateTimePicker(
                                  type: DateTimePickerType.date,
                                  dateMask: 'd MMM, yyyy',
                                  initialValue: initDate.toString(),
                                  firstDate: DateTime.now()
                                      .add(const Duration(days: 1)),
                                  lastDate: DateTime(2100),
                                  icon: Icon(Icons.event),
                                  dateLabelText: 'Date',
                                  timeLabelText: "Hour",
                                  locale: const Locale('it', 'IT'),
                                  selectableDayPredicate: (date) {
                                    // Disable weekend days to select from the calendar

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
                                      icon: Icon(Icons.access_time),
                                      hintText: '',
                                      labelText: 'Ora appuntamento',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Per favore, inserisci l\'ora dell\'appuntamento!';
                                      }
                                      return null;
                                    },
                                    enableInteractiveSelection: false,
                                    showCursor: false,
                                    controller: timeController,
                                    keyboardType: TextInputType.none,
                                    onTap: test);
                              }),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 150.0, top: 40.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_prenotazioneFormKey.currentState!
                                        .validate()) {
                                      inizializza(
                                          dateController, timeController.text);

                                      Navigator.pop(context);

                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      //createRecord(utente);
                                    }
                                  },
                                  child: const Text('Inizializza prenotazione'),
                                ),
                              ),
                            ],
                          )))
                    else if (prenotazione.getDataPrenotazione != null)
                      Text(
                          "Data appuntamento: ${DateTime.parse(prenotazione.getDataPrenotazione.toDate().toString())}")
                  ],
                ))
          ]))
    ]));
  }

  void inizializza(String date, time) {
    var parsedDate = DateTime.parse("$date $time");
    Timestamp ts = Timestamp.fromDate(parsedDate);
    PrenotazioneController control = PrenotazioneController();
    control.inizializzaPrenotazione(prenotazione.getId, utente, ts);
  }

  void test() async {
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

  Future<void> _pullRefresh() async {
    setState(() {
      //prenotazioni = freshList;
    });
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAA");
  }
}
