import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/entity_GA/super_utente.dart';
import 'package:report_it/domain/entity/entity_GF/discussione_entity.dart';
import 'package:report_it/domain/repository/forum_controller.dart';

class Commenti extends StatefulWidget {
  const Commenti(
      {super.key, required this.discussione, required this.callback});
  final Discussione discussione;
  final callback;

  @override
  State<Commenti> createState() => _CommentiState();
}

class _CommentiState extends State<Commenti> {
  bool commenti = true;
  User? utente = FirebaseAuth.instance.currentUser;

  TextEditingController testo = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var lista = List.empty(growable: true);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.6,
            MediaQuery.of(context).size.width * 0.01,
            0,
            0,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  commenti = !commenti;
                });
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                    child: Icon(Icons.comment, color: Colors.blue.shade500),
                  ),
                  const Text("Commenta"),
                ],
              ),
            ),
          ),
        ),
        commenti == false
            ? Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: FutureBuilder(
                            future: ForumService()
                                .retrieveCommenti(widget.discussione.id!),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              } else {
                                lista.addAll(snapshot.data);
                                return ListView.builder(
                                  itemCount: lista.length,
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade400,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.account_circle,
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${lista[index]!.nome!} ${lista[index]!.cognome!}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child:
                                                    Text(lista[index]!.testo)),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              }
                            }),
                      ),
                      widget.discussione.stato == "Aperta"
                          ? Form(
                              key: _formKey,
                              child: Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: TextFormField(
                                      controller: testo,
                                      decoration: InputDecoration(
                                        hintText: "Inserisci un testo",
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        contentPadding:
                                            const EdgeInsets.all(20.0),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Per favore, inserisci un testo';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Consumer<SuperUtente?>(builder:
                                          (context, superutente, child) {
                                        return InkWell(
                                          onTap: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              var c = await ForumService()
                                                  .aggiungiCommento(
                                                testo.text,
                                                utente!.uid,
                                                widget.discussione.id!,
                                                superutente,
                                              );
                                              testo.clear();
                                              setState(() {
                                                lista.add(c);
                                              });
                                            }
                                          },
                                          child: const Icon(
                                            Icons.send,
                                            size: 30,
                                          ),
                                        );
                                      }),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
