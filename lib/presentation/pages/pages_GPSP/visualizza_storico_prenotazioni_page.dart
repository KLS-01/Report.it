import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/entity_GPSP/prenotazione_entity.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/domain/repository/prenotazione_controller.dart';
import 'package:report_it/presentation/widget/lista_prenotazioni_widget.dart';
import 'test_prenotazioni.dart';
import 'visualizza_prenotazioni_attive_page.dart';

Color? containerColor;
List<Color> containerColors = [
  const Color(0xFFFDE1D7),
  const Color(0xFFE4EDF5),
  const Color(0xFFE7EEED),
  const Color(0xFFF4E4CE),
];

class VisualizzaStoricoPrenotazioniPage extends StatefulWidget {
  const VisualizzaStoricoPrenotazioniPage({Key? key}) : super(key: key);

  @override
  State<VisualizzaStoricoPrenotazioniPage> createState() =>
      _VisualizzaStoricoPrenotazioniPageState();
}

class _VisualizzaStoricoPrenotazioniPageState
    extends State<VisualizzaStoricoPrenotazioniPage> {
  late Future<List<Prenotazione>> prenotazioni;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Column(children: [
        Expanded(
          child: Consumer<SuperUtente?>(builder: (context, utente, child) {
            if (utente == null) {
              //se l'utente è null resituisce errore
              return const Text("Errore non sei loggato");
            } else {
              if (utente.tipo == TipoUtente.UffPolGiud) {
                //se l'utente è un UffPolGiud restituisce errore
                return const Text(
                    "Non hai l'autorizzazione per visualizzare la pagina");
              } else if (utente.tipo == TipoUtente.Utente) {
                //se l'utente è di tipo Utente, genera la lista per l'utente
                print(utente.id);
                prenotazioni = generaListaStoricoPrenotazioniUtente(utente);
              } else if (utente.tipo == TipoUtente.OperatoreCup) {
                //altrimenti se l'utente è di tipo Operatore, genera la lista per l'operatore
                prenotazioni = generaListaStoricoPrenotazioniOperatore(utente);
              }
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 250, top: 100),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Scaffold(
                                    body:
                                        VisualizzaPrenotazioniAttivePage()))); //Reindirizza alla pagina prenotazioni attive
                      },
                      child: const Text("Visualizza attive")),
                ),
                //Presente solo se l'utente è di tipo Utente
                if (utente.tipo == TipoUtente.Utente)
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PrenotazionePage())); //Reindirizza alla pagina per effettuare una prenotazione
                        },
                        child: const Text("Prenota")),
                  ),
                const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text("Storico prenotazioni"),
                ),
                Expanded(
                    child: FutureBuilder<List<Prenotazione>>(
                  future: prenotazioni,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Prenotazione>> snapshot) {
                    return PrenotazioneListWidget(
                        snapshot: snapshot,
                        utente:
                            utente); //Genera la lista di prenotazione utilizzando il widget PrenotazioneListWidget
                  },
                ))
              ]);
            }
          }),
        )
      ]),
    );
  }
}

Future<List<Prenotazione>> generaListaStoricoPrenotazioniUtente(
    SuperUtente? utente) async {
  PrenotazioneController controller = PrenotazioneController();
  return controller.visualizzaStoricoByUtente(utente);
}

Future<List<Prenotazione>> generaListaStoricoPrenotazioniOperatore(
    SuperUtente? utente) async {
  PrenotazioneController controller = PrenotazioneController();
  return controller.visualizzaStoricoByOperatore(utente);
}

Future<List<Prenotazione>> generaListaPrenotazioniAttiveUtente(
    SuperUtente? utente) async {
  PrenotazioneController controller = PrenotazioneController();
  return controller.visualizzaAttiveByUtente(utente);
}

Future<List<Prenotazione>> generaListaPrenotazioniAttive(
    SuperUtente? utente) async {
  PrenotazioneController controller = PrenotazioneController();
  print(utente!.id);
  return controller.visualizzaAttive(utente);
}
