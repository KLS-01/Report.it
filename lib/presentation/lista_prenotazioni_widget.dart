import 'package:flutter/material.dart';
import 'package:report_it/domain/entity/prenotazione_entity.dart';

class PrenotazioneListWidget extends StatelessWidget {
  final AsyncSnapshot<List<Prenotazione>> snapshot;

  const PrenotazioneListWidget({
    super.key,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    var data = snapshot.data;
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
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) {
            final item = snapshot.data![index];

            return Material(
              child: ListTile(
                title: Text(item.id!),
              ),
            );
          },
        );
      }
    }
  }
}
