import 'package:flutter/material.dart';
import 'package:report_it/domain/entity/entity_GC/chatbot_entity.dart';
import 'package:report_it/domain/repository/chatbot_controller.dart';
import 'package:report_it/presentation/widget/icona_bot.dart';
import 'package:report_it/presentation/widget/styles.dart';

class HomeChat extends StatelessWidget {
  const HomeChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeText.theme.backgroundColor,
          iconTheme: IconThemeData(color: ThemeText.theme.primaryColor),
        ),
        body: crealista(list: ChatBotController().retrieveAll()));
  }
}

class crealista extends StatefulWidget {
  const crealista({super.key, required this.list});

  final Future<List<ChatB?>?> list;

  @override
  State<crealista> createState() => _crealistaState();
}

class _crealistaState extends State<crealista> {
  bool selezionato = false;
  String? risposta;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.list,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
              ],
            );
          } else {
            return Container(
              margin: EdgeInsets.fromLTRB(5, 10, 10, 10),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ImageIcon(
                                    AssetImage("assets/images/chatbot.png"),
                                    color: ThemeText.theme.primaryColor,
                                  ),
                                  SizedBox(width: 5),
                                  Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    color: ThemeText.theme.primaryColor,
                                    child: InkWell(
                                      onTap: (() {
                                        if (risposta == null) {
                                          risposta =
                                              snapshot.data![index]!.risposta;
                                        } else if (risposta !=
                                            snapshot.data![index]!.risposta) {
                                          risposta =
                                              snapshot.data![index]!.risposta;
                                        } else {
                                          risposta = null;
                                        }
                                        setState(() {});
                                      }),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(219, 29, 69, 1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 35),
                                        child: Text(
                                          snapshot.data![index]!.domanda,
                                          textAlign: TextAlign.center,
                                          style: ThemeText.corpoInoltro,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  risposta == null
                      ? Container()
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    color: ThemeText.theme.primaryColor,
                                    child: InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[350],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 35),
                                        child: Text(
                                          risposta!,
                                          textAlign: TextAlign.center,
                                          style: ThemeText.corpoInoltro,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.computer,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            );
          }
        });
  }
}
