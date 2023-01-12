import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:report_it/data/models/AutenticazioneDAO.dart';
import 'package:report_it/domain/entity/entity_GA/operatoreCUP_entity.dart';
import 'package:report_it/domain/entity/entity_GPSP/prenotazione_entity.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/repository/prenotazione_controller.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class InformazioniPrenotazione extends StatefulWidget {
  final Prenotazione prenotazione;
  final SuperUtente utente;
  const InformazioniPrenotazione(
      {Key? key, required this.prenotazione, required this.utente})
      : super(key: key);

  @override
  State<InformazioniPrenotazione> createState() =>
      _InformazioniPrenotazione(prenotazione: prenotazione, utente: utente);
}

class _InformazioniPrenotazione extends State<InformazioniPrenotazione> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  late Prenotazione prenotazione;
  late SuperUtente utente;
  final _prenotazioneFormKey = GlobalKey<FormState>();
  var dateController;

  _InformazioniPrenotazione({required this.prenotazione, required this.utente});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 10),
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(context);
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
                    const Text("IDUtente"),
                    Text(prenotazione.getId),
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
                    if (prenotazione.getDataPrenotazione == null)
                      Form(
                          key: _prenotazioneFormKey,
                          child: SingleChildScrollView(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Builder(builder: (context) {
                                return DateTimePicker(
                                  type: DateTimePickerType.dateTimeSeparate,
                                  dateMask: 'd MMM, yyyy',
                                  initialValue: DateTime.now().toString(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  icon: Icon(Icons.event),
                                  dateLabelText: 'Date',
                                  timeLabelText: "Hour",
                                  selectableDayPredicate: (date) {
                                    // Disable weekend days to select from the calendar
                                    if (date.weekday == 6 ||
                                        date.weekday == 7) {
                                      return false;
                                    }

                                    return true;
                                  },
                                  onChanged: (val) => dateController = val,
                                  validator: (val) {
                                    return null;
                                  },
                                  onSaved: (val) => dateController = val,
                                );
                              }),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 150.0, top: 40.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_prenotazioneFormKey.currentState!
                                        .validate()) {
                                      inizializza(dateController);
                                      Navigator.of(context, rootNavigator: true)
                                          .pop(context);
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
                    else
                      Text(
                          "Data appuntamento: ${DateTime.parse(prenotazione.getDataPrenotazione.toDate().toString())}")
                  ],
                ))
          ]))
    ]));
  }

  void inizializza(String val) {
    var parsedDate = DateTime.parse(val);
    Timestamp ts = Timestamp.fromDate(parsedDate);
    PrenotazioneController control = PrenotazioneController();
    control.inizializzaPrenotazione(prenotazione.getId, utente, ts);
    //passare al controller e chiamare metodo inizializzazione
  }
}
