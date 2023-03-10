import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/application/entity/entity_GD/stato_denuncia.dart';
import 'package:report_it/application/entity/entity_GA/super_utente.dart';
import 'package:report_it/application/entity/entity_GA/tipo_utente.dart';

import '../../application/entity/entity_GD/denuncia_entity.dart';
import '../pages/pages_GD/dettagli_denuncia_page.dart';

class VisualizzaDenunceWidget extends StatefulWidget {
  final List<Denuncia> denunce;
  const VisualizzaDenunceWidget({Key? key, required this.denunce})
      : super(key: key);

  @override
  State<VisualizzaDenunceWidget> createState() =>
      _VisualizzaDenunceWidgetState(denunce: denunce);
}

class _VisualizzaDenunceWidgetState extends State<VisualizzaDenunceWidget> {
  _VisualizzaDenunceWidgetState({required this.denunce});
  List<Denuncia> denunce;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: Consumer<SuperUtente?>(
            builder: (context, utente, _) {
              if (utente == null) {
                return const Text("Non sei loggato");
              } else {
                if (utente.tipo == TipoUtente.OperatoreCup) {
                  return const Text("Errore, non hai i permessi");
                } else {
                  if (denunce.length == 0) {
                    return const CustomScrollView(
                      slivers: <Widget>[
                        SliverFillRemaining(
                          child: Center(
                            child: Text("Nessuna denuncia trovata"),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      itemCount: denunce.length,
                      itemBuilder: (context, index) {
                        final item = denunce[index];

                        return index != (denunce.length - 1)
                            ? DenunciaBox(
                                item: item,
                                utente: utente,
                              )
                            : Column(
                                children: [
                                  DenunciaBox(
                                    item: item,
                                    utente: utente,
                                  ),
                                  SizedBox(
                                    height: 70,
                                  ),
                                ],
                              );
                      },
                    );
                  }
                }
              }
            },
          ),
        ),
      ],
    );
  }
}

class DenunciaBox extends StatefulWidget {
  const DenunciaBox({super.key, required this.item, required this.utente});

  final Denuncia item;
  final utente;

  @override
  State<DenunciaBox> createState() => _DenunciaBoxState();
}

class _DenunciaBoxState extends State<DenunciaBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8.0,
            spreadRadius: 1.0,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          Consumer<SuperUtente?>(builder: (context, utente, _) {
            switch (widget.item.statoDenuncia) {
              case StatoDenuncia.NonInCarico:
                return const Icon(
                  Icons.circle,
                  color: Colors.amberAccent,
                );
              case StatoDenuncia.PresaInCarico:
                return const Icon(
                  Icons.circle,
                  color: Colors.green,
                );
              case StatoDenuncia.Chiusa:
                return Icon(
                  Icons.circle,
                  color: Colors.grey.shade400,
                );
            }
          }),
          Expanded(
            child: SizedBox(
              height: 75.0,
              child: ListTile(
                title: Text(
                  widget.item.id!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text("Clicca sull'icona per vedere i dettagli"),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DettagliDenunciaRebecca(
                        denunciaId: widget.item.id!, utente: widget.utente),
                  ),
                );
              },
              icon: const Icon(
                Icons.info_outline_rounded,
              )),
        ],
      ),
    );
  }
}
