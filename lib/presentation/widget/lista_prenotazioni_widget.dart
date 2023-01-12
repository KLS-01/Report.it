import 'package:flutter/material.dart';
import 'package:report_it/domain/entity/entity_GPSP/prenotazione_entity.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';
import 'package:report_it/presentation/pages/pages_GPSP/informazioni_prenotazione_page.dart';

class PrenotazioneListWidget extends StatefulWidget {
  final AsyncSnapshot<List<Prenotazione>> snapshot;
  final SuperUtente utente;
  const PrenotazioneListWidget(
      {super.key, required this.snapshot, required this.utente});

  @override
  State<PrenotazioneListWidget> createState() => _PrenotazioneListWidgetState();
}

class _PrenotazioneListWidgetState extends State<PrenotazioneListWidget> {
  @override
  Widget build(BuildContext context) {
    var data = widget.snapshot.data;
    if (data == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      var datalenght = data.length;
      if (datalenght == 0) {
        return const Center(
          child: Text('Nessuna prenotazione trovata'),
        );
      } else {
        return ListView.builder(
          itemCount: widget.snapshot.data?.length,
          itemBuilder: (context, index) {
            final item = widget.snapshot.data![index];

            return Material(
              child: Column(
                children: [
                  ListTile(
                    title: Text(item.id!),
                  ),
                  if (widget.utente.tipo == TipoUtente.OperatoreCup)
                    ElevatedButton(
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Scaffold(
                                          body: InformazioniPrenotazione(
                                              prenotazione: item,
                                              utente: widget.utente))))
                            },
                        child: const Text("Apri prenotazione"))
                ],
              ),
            );
          },
        );
      }
    }
  }
}
