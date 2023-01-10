import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/entity_GD/stato_denuncia.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_utente.dart';

import '../../domain/entity/entity_GD/denuncia_entity.dart';
import '../../../domain/repository/denuncia_controller.dart';
import '../pages/pages_GD/dettagli_denuncia_page.dart';
import '../pages/pages_GD/inoltro_denuncia_page.dart';

class VisualizzaDenunceWidget extends StatefulWidget {
  final Future<List<Denuncia>> denunce;
  const VisualizzaDenunceWidget({Key? key, required this.denunce}) : super(key: key);

  @override
  State<VisualizzaDenunceWidget> createState() => _VisualizzaDenunceWidgetState(denunce: denunce);
}

class _VisualizzaDenunceWidgetState extends State<VisualizzaDenunceWidget> {
  _VisualizzaDenunceWidgetState({required this.denunce});
  Future<List<Denuncia>> denunce;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: Consumer<SuperUtente?>(
            builder: (context, utente,_){
              if(utente==null){
                return const Text("non sei loggato");
              }
              else{
                if(utente.tipo== TipoUtente.OperatoreCup){
                  return const Text("Errore non hai i permessi");
                }
                else{
                  return FutureBuilder<List<Denuncia>>(
                    future: denunce,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Denuncia>> snapshot) {
                      var data = snapshot.data;
                      if (data == null) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else {
                        var datalenght = data.length;
                        if (datalenght == 0) {
                          return const Center(
                            child: Text('Nessuna denuncia trovata'),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              final item = snapshot.data![index];

                              return Container(
                                margin: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.2),
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
                                    Consumer<SuperUtente?>(
                                      builder: (context,utente,_){
                                        switch(item.statoDenuncia) {
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
                                            color: Colors.green.shade400,
                                          );
                                        }
                                        }
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 75.0,
                                        child: ListTile(
                                          title: Text(
                                            item.descrizione,
                                            style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(item
                                              .categoriaDenuncia
                                              .toString()),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DettagliDenunciaRebecca(denunciaId: item.id!, utente:utente,),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.info_outline_rounded,
                                        ))
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      }
                    },
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }
}



