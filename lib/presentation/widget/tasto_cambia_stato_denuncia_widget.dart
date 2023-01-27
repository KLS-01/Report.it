import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:report_it/presentation/widget/styles.dart';

import '../../domain/entity/entity_GA/super_utente.dart';
import '../../domain/entity/entity_GA/tipo_utente.dart';
import '../../domain/entity/entity_GD/denuncia_entity.dart';
import '../../domain/entity/entity_GD/stato_denuncia.dart';
import '../../domain/repository/denuncia_controller.dart';

class generaTastoCambiaStato extends StatelessWidget {
  const generaTastoCambiaStato(
      {Key? key, required this.denuncia, required this.utente})
      : super(key: key);
  final Denuncia denuncia;
  final SuperUtente utente;

  @override
  Widget build(BuildContext context) {
    if (utente.tipo == TipoUtente.UffPolGiud) {
      switch (denuncia.statoDenuncia) {
        case StatoDenuncia.NonInCarico:
          return ElevatedButton(
              style: ThemeText.bottoneRosso,
              onPressed: () =>
                  showAlertDialogAccetta(context, denuncia, utente),
              child: const Text("Prendi in carico"));
        case StatoDenuncia.PresaInCarico:
          return ElevatedButton(
              style: ThemeText.bottoneRosso,
              onPressed: () => showAlertDialogChiudi(context, denuncia, utente),
              child: const Text("Chiudi la pratica"));
        case StatoDenuncia.Chiusa:
          return const Visibility(
            visible: false,
            child: Text(""),
          );
      }
    } else {
      return const Visibility(visible: false, child: Text(""));
    }
  }

  showAlertDialogAccetta(
      BuildContext context, Denuncia denuncia, SuperUtente utente) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Attenzione!", style: ThemeText.titoloAlert),
          content: const Text(
              "Sei sicuro di voler prendere in carico la denuncia?",
              style: ThemeText.corpoInoltro),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, "Cancel"),
              style: ThemeText.bottoneRosso,
              child: const Text("Torna indietro"),
            ),
            ElevatedButton(
              style: ThemeText.bottoneRosso,
              onPressed: () async {
                await DenunciaController().accettaDenuncia(denuncia, utente);
                Navigator.pop(context, "Continue");

                Fluttertoast.showToast(
                    msg: "Denuncia presa in carico correttamente!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.grey.shade200,
                    textColor: Colors.black,
                    fontSize: 15.0);
              },
              child: const Text("Prendi in carico"),
            ),
          ],
        );
      },
    );
  }

  showAlertDialogChiudi(
      BuildContext context, Denuncia denuncia, SuperUtente utente) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Attenzione!", style: ThemeText.titoloAlert),
          content: const Text("Sei sicuro di voler chiudere la pratica?",
              style: ThemeText.corpoInoltro),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, "Cancel"),
              style: ThemeText.bottoneRosso,
              child: const Text("No"),
            ),
            ElevatedButton(
              style: ThemeText.bottoneRosso,
              onPressed: () {
                DenunciaController().chiudiDenuncia(denuncia, utente);
                Navigator.pop(context, "Continue");
                Fluttertoast.showToast(
                    msg: "Denuncia chiusa con successo!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.grey.shade200,
                    textColor: Colors.black,
                    fontSize: 15.0);
              },
              child: const Text("Sì"),
            ),
          ],
        );
      },
    );
  }
}
