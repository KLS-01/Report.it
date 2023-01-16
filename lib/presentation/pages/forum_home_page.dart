// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:report_it/domain/repository/forum_service.dart';
import 'package:report_it/presentation/pages/form_crea_discussione.dart';
import 'package:report_it/presentation/widget/crealista.dart';

class ForumHome extends StatefulWidget {
  const ForumHome({super.key});

  @override
  State<ForumHome> createState() => _ForumHomeState();
}

class _ForumHomeState extends State<ForumHome> {
  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(255, 254, 248, 1),
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Theme.of(context).backgroundColor,
            bottom: const TabBar(
              labelColor: Color.fromRGBO(219, 29, 69, 1),
              indicatorColor: Color.fromRGBO(219, 29, 69, 1),
              tabs: [
                Tab(
                  child: Text("Tutte le discussioni"),
                ),
                Tab(
                  child: Text("Le tue discussioni"),
                )
              ],
            ),
          ),
          body: TabBarView(children: [
            crealista(
              list: ForumService.PrendiTutte(),
              Callback: callback,
            ),
            crealista(
              list: ForumService().Prendiutente(),
              Callback: callback,
            )
          ]),
          floatingActionButton: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  //pisnelo
                  pageBuilder: (_, __, ___) => const ForumForm(),
                  transitionDuration: const Duration(seconds: 0),
                  transitionsBuilder: (_, a, __, c) =>
                      FadeTransition(opacity: a, child: c),
                ),
              ).then((value) {
                ForumService().AggiornaLista();
                setState(() {});
              });
              //
            },
            backgroundColor: const Color.fromRGBO(219, 29, 69, 1),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

// class crealista extends StatefulWidget {
//   const crealista({super.key, required this.list, required this.Callback});

//   final Future<List<Discussione?>?> list;
//   final Callback;

//   @override
//   State<crealista> createState() => _crealistaState();
// }

// class _crealistaState extends State<crealista> {
//   User? utente = FirebaseAuth.instance.currentUser;
//   void callback2() {
//     setState(() {});
//   }

//   bool commenti = false;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: widget.list,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: ((context, index) {
//                 bool flag =
//                     snapshot.data![index]!.listaSostegno.contains(utente!.uid);
//                 int numero = snapshot.data![index]!.listaSostegno.length;
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 25),
//                   child: Stack(
//                     fit: StackFit.passthrough,
//                     children: [
//                       Container(
//                         child: Card(
//                           elevation: 8,
//                           color: Colors.grey.shade100,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                             //set border radius more than 50% of height and width to make circle
//                           ),
//                           child: Column(
//                             children: [
//                               Container(
//                                 width: MediaQuery.of(context).size.width,
//                                 padding: EdgeInsets.all(
//                                   MediaQuery.of(context).size.height * 0.01,
//                                 ),
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: const BorderRadius.only(
//                                         topLeft: Radius.circular(20),
//                                         topRight: Radius.circular(20))),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         children: [
//                                           const Icon(
//                                             Icons.account_circle,
//                                             size: 30,
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             "${snapshot.data![index]!.nome!} ${snapshot.data![index]!.cognome!}",
//                                             style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 18),
//                                           ),
//                                         ],
//                                       ),
//                                       const Divider(
//                                         color: Colors.grey,
//                                         height: 20,
//                                         thickness: 1,
//                                         indent: 1,
//                                         endIndent: 1,
//                                       ),
//                                       Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Text(
//                                           snapshot.data![index]!.titolo,
//                                           style: const TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     snapshot.data![index]!.testo,
//                                     style: const TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               CardImaggine(
//                                 immagine: snapshot.data![index]!.pathImmagine,
//                               ),
//                               Stack(
//                                 children: [
//                                   Container(
//                                     width: MediaQuery.of(context).size.width,
//                                     padding: EdgeInsets.all(
//                                       MediaQuery.of(context).size.height * 0.01,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade300,
//                                       borderRadius: const BorderRadius.only(
//                                           bottomLeft: Radius.circular(20),
//                                           bottomRight: Radius.circular(20)),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         like(
//                                           discussione: snapshot.data![index]!,
//                                           callback: callback2,
//                                           flag: flag,
//                                           numero: numero,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Commenti(
//                                     discussione: snapshot.data![index]!,
//                                     callback: callback2,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Consumer<SuperUtente?>(
//                         builder: ((context, value, child) {
//                           return value!.id == snapshot.data![index]!.idCreatore
//                               ? Padding(
//                                   padding: EdgeInsets.fromLTRB(
//                                       MediaQuery.of(context).size.width * 0.85,
//                                       0,
//                                       0,
//                                       0),
//                                   child: Material(
//                                     color: Colors.transparent,
//                                     child: PopupMenuButton(
//                                       itemBuilder: (context) {
//                                         List<PopupMenuEntry<Object>> list = [];
//                                         list.add(
//                                           snapshot.data![index]!.stato ==
//                                                   "Aperta"
//                                               ? PopupMenuItem(
//                                                   onTap: (() {
//                                                     ForumService()
//                                                         .ChiudiDiscussione(
//                                                             snapshot
//                                                                 .data![index]!
//                                                                 .id);
//                                                     ForumService()
//                                                         .AggiornaLista();
//                                                     widget.Callback();
//                                                   }),
//                                                   child: const Text(
//                                                       "Chiudi discussione"),
//                                                 )
//                                               : PopupMenuItem(
//                                                   onTap: (() {
//                                                     ForumService()
//                                                         .ApriDiscussione(
//                                                             snapshot
//                                                                 .data![index]!
//                                                                 .id);
//                                                     ForumService()
//                                                         .AggiornaLista();
//                                                     widget.Callback();
//                                                   }),
//                                                   child: const Text(
//                                                       "Apri discussione"),
//                                                 ),
//                                         );
//                                         list.add(
//                                           PopupMenuItem(
//                                             onTap: (() {
//                                               ForumService().EliminaDiscussione(
//                                                   snapshot.data![index]!.id);
//                                               ForumService().AggiornaLista();
//                                               widget.Callback();
//                                             }),
//                                             child: const Text(
//                                                 "Elimina discussione"),
//                                           ),
//                                         );
//                                         return list;
//                                       },
//                                     ),
//                                   ),
//                                 )
//                               : Container();
//                         }),
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//             );
//           }
//         });
//   }
// }

// class like extends StatefulWidget {
//   like({
//     super.key,
//     required this.discussione,
//     required this.callback,
//     required this.flag,
//     required this.numero,
//   });
//   Discussione discussione;
//   Function callback;
//   bool flag;
//   int numero;

//   @override
//   State<like> createState() => _likeState();
// }

// class _likeState extends State<like> {
//   User? utente = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(widget.numero.toString()),
//         Material(
//           color: Colors.transparent,
//           child: !widget.flag
//               ? InkWell(
//                   onTap: () {
//                     setState(() {
//                       widget.flag = !widget.flag;
//                       widget.numero += 1;
//                     });
//                     ForumService().sostieniDiscusione(
//                       widget.discussione.id!,
//                       utente!.uid,
//                     );
//                   },
//                   child: const Icon(
//                     Icons.favorite_border_outlined,
//                     color: Colors.red,
//                     size: 30,
//                   ),
//                 )
//               : InkWell(
//                   onTap: () {
//                     ForumService().desostieniDiscusione(
//                       widget.discussione.id!,
//                       utente!.uid,
//                     );
//                     setState(() {
//                       widget.flag = !widget.flag;
//                       widget.numero -= 1;
//                     });
//                   },
//                   child: const Icon(
//                     Icons.favorite,
//                     color: Colors.red,
//                     size: 30,
//                   ),
//                 ),
//         ),
//       ],
//     );
//   }
// }

// class Commenti extends StatefulWidget {
//   const Commenti(
//       {super.key, required this.discussione, required this.callback});
//   final Discussione discussione;
//   final callback;

//   @override
//   State<Commenti> createState() => _CommentiState();
// }

// class _CommentiState extends State<Commenti> {
//   bool commenti = true;
//   User? utente = FirebaseAuth.instance.currentUser;

//   TextEditingController testo = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     var lista = widget.discussione.commenti;
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.fromLTRB(
//             MediaQuery.of(context).size.width * 0.6,
//             MediaQuery.of(context).size.width * 0.01,
//             0,
//             0,
//           ),
//           child: Material(
//             color: Colors.transparent,
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   commenti = !commenti;
//                 });
//               },
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 0, 9, 0),
//                     child: Icon(Icons.comment, color: Colors.blue.shade500),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(lista.length.toString()),
//                   ),
//                   const Text("Commenta"),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         commenti == false
//             ? Flexible(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(20),
//                       bottomRight: Radius.circular(20),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: lista.isNotEmpty ? 150 : 20,
//                         child: ListView.builder(
//                           itemCount: lista.length,
//                           itemBuilder: ((context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 width: MediaQuery.of(context).size.width,
//                                 padding: EdgeInsets.all(
//                                   MediaQuery.of(context).size.height * 0.01,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade400,
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(20)),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.account_circle,
//                                           size: 20,
//                                         ),
//                                         const SizedBox(
//                                           width: 5,
//                                         ),
//                                         Text(
//                                           "${lista[index]!.nome!} ${lista[index]!.cognome!}",
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                     Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Text(lista[index]!.testo)),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }),
//                         ),
//                       ),
//                       widget.discussione.stato == "Aperta"
//                           ? Form(
//                               key: _formKey,
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width * 0.8,
//                                     child: TextFormField(
//                                       controller: testo,
//                                       decoration: InputDecoration(
//                                         hintText: "Inserisci un testo",
//                                         filled: true,
//                                         fillColor: Colors.grey[200],
//                                         border: OutlineInputBorder(
//                                             borderSide: BorderSide.none,
//                                             borderRadius:
//                                                 BorderRadius.circular(20)),
//                                         contentPadding:
//                                             const EdgeInsets.all(20.0),
//                                       ),
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return 'Per favore, inserisci un testo';
//                                         }
//                                         return null;
//                                       },
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                                     child: Material(
//                                       color: Colors.transparent,
//                                       child: Consumer<SuperUtente?>(builder:
//                                           (context, superutente, child) {
//                                         return InkWell(
//                                           onTap: () async {
//                                             if (_formKey.currentState!
//                                                 .validate()) {
//                                               var c = await ForumService()
//                                                   .aggiungiCommento(
//                                                 testo.text,
//                                                 utente!.uid,
//                                                 widget.discussione.id!,
//                                                 superutente,
//                                               );
//                                               testo.clear();
//                                               setState(() {
//                                                 lista.add(c);
//                                               });
//                                             }
//                                           },
//                                           child: const Icon(
//                                             Icons.send,
//                                             size: 30,
//                                           ),
//                                         );
//                                       }),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             )
//                           : Container(),
//                     ],
//                   ),
//                 ),
//               )
//             : Container(),
//       ],
//     );
//   }
// }
