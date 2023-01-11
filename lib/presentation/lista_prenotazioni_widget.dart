import 'package:flutter/material.dart';
import 'package:report_it/domain/entity/prenotazione_entity.dart';
import 'package:report_it/domain/entity/super_utente.dart';
import 'package:report_it/domain/entity/tipo_utente.dart';
import 'package:report_it/presentation/pages/informazioni_prenotazione_page.dart';

class PrenotazioneListWidget extends StatefulWidget {
  final List<Prenotazione>? snapshot;
  final SuperUtente utente;

  const PrenotazioneListWidget({
    super.key,
    required this.snapshot,
    required this.utente,
  });

  @override
  State<PrenotazioneListWidget> createState() => _PrenotazioneListWidgetState(
        snapshot: snapshot,
        utente: utente,
      );
}

class _PrenotazioneListWidgetState extends State<PrenotazioneListWidget> {
  _PrenotazioneListWidgetState({
    required this.snapshot,
    required this.utente,
  });
  List<Prenotazione>? snapshot;
  final SuperUtente utente;

  @override
  Widget build(BuildContext context) {
    if (snapshot == null) {
      return const Center(child: Text('Errore'));
    }
    if (snapshot!.isEmpty) {
      return const Center(
        child: Text('Nessuna prenotazione trovata'),
      );
    } else {
      return ListView.builder(
        itemCount: snapshot!.length,
        itemBuilder: (context, index) {
          final item = snapshot![index];

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
