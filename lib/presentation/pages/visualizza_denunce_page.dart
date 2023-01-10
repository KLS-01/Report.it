// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:report_it/data/Models/denuncia_dao.dart';
// import 'package:report_it/domain/entity/categoria_denuncia.dart';
// import 'package:report_it/domain/entity/stato_denuncia.dart';

// import '../../domain/entity/denuncia_entity.dart';
// import '../../domain/entity/utente_entity.dart';
// import '../../../domain/repository/denuncia_controller.dart';

// import 'package:flutter/material.dart';
// import '../../../domain/repository/denuncia_controller.dart';

// class VisualizzaDenunceUtentePage extends StatefulWidget {
//   const VisualizzaDenunceUtentePage({Key? key}) : super(key: key);

//   @override
//   State<VisualizzaDenunceUtentePage> createState() =>
//       _VisualizzaDenunceUtentePageState();
// }

// class _VisualizzaDenunceUtentePageState
//     extends State<VisualizzaDenunceUtentePage> {
//   late Future<List<Denuncia>> denunce;

//   @override
//   void initState() {
//     super.initState();
//     denunce = generaListaDenunce();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text("le tue denunce"),
//         FutureBuilder<List<Denuncia>>(
//           future: denunce,
//           builder:
//               (BuildContext context, AsyncSnapshot<List<Denuncia>> snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data?.length,
//                 itemBuilder: (context, index) {
//                   final item = snapshot.data![index];

//                   return ListTile(
//                     title: Text(item.descrizione),
//                     subtitle: const ElevatedButton(
//                         onPressed: createRecord, child: Text("aggiungi")),
//                   );
//                 },
//               );
//             } else {
//               return const Text('Non hai denuncee aaaaaaaaaaa');
//             }
//           },
//         )
//       ],
//     );
//   }
// }

// Future<List<Denuncia>> generaListaDenunce() {
//   DenunciaController controller = DenunciaController();

//   return controller.visualizzaDenunceByUtente();
// }

// void stampaDenunce() async {
//   DenunciaDao dao = new DenunciaDao();
//   print("stampo tutte le denunce");
//   List<Denuncia> lista = (await dao.retrieveAll()) as List<Denuncia>;
//   print("stampa 2");
//   for (var d in lista) {
//     print(d);
//   }
// }

// void createRecord() {
//   Timestamp scadenzaTS = Timestamp.fromDate(DateTime.now());
//   Timestamp dataDenuncia = Timestamp.fromDate(DateTime.now());
//   GeoPoint coord = const GeoPoint(3.4, 4.5);
//   Denuncia d = Denuncia(
//       id: null,
//       idUtente: "dVd0S4ptsafnEqPJq938mjEmH3s2",
//       nomeDenunciante: "Tizio",
//       cognomeDenunciante: "Caio",
//       indirizzoDenunciante: "Via Roma 23",
//       capDenunciante: "543534",
//       provinciaDenunciante: "PD",
//       cellulareDenunciante: "548894231658",
//       emailDenunciante: "tizio@email.it",
//       tipoDocDenunciante: "Carta d'identità",
//       numeroDocDenunciante: "420420420420",
//       scadenzaDocDenunciante: scadenzaTS,
//       dataDenuncia: dataDenuncia,
//       categoriaDenuncia: CategoriaDenuncia.OrigineNazionale,
//       nomeVittima: "Tizio",
//       cognomeVittima: "Caio",
//       denunciato: "Nicola Frvgieri",
//       alreadyFiled: false,
//       consenso: true,
//       descrizione: "Denuncia per discriminazione ecceccc",
//       statoDenuncia: StatoDenuncia.PresaInCarico,
//       nomeCaserma: "Caserma",
//       coordCaserma: coord,
//       nomeUff: "Adol",
//       cognomeUff: "Fitler",
//       idUff: " 1PZNxmcGrWVN2ezktgyKFVRWdBS2");

//   DenunciaDao.addDenuncia(d).then((DocumentReference<Object?> id) {
//     d.setId = id.id;
//     DenunciaDao.updateId(d.getId);
//   });
// }
