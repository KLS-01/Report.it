import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/stato_denuncia.dart';
import 'package:report_it/domain/entity/super_utente.dart';
import 'package:report_it/domain/entity/tipo_utente.dart';

import '../../domain/entity/denuncia_entity.dart';
import '../../../domain/repository/denuncia_controller.dart';
import '../pages/dettagli_denuncia_page.dart';
import '../pages/inoltro_denuncia_page.dart';

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
                                  // color: Color.fromARGB(255, 228, 228, 228),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 2.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(1.5, 1.5),
                                      )
                                    ]),
                                child: ListTile(
                                  title: Text(item.descrizione),
                                  subtitle:
                                  Text(item.categoriaDenuncia.toString()),
                                  trailing: ElevatedButton(
                                    onPressed: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder:(context)=>DettagliDenuncia(denunciaId: item.id!, utente:utente))
                                      );
                                    },
                                    child: Text("Dettagli"),
                                  ),
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



