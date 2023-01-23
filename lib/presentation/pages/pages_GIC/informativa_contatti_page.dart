import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:report_it/presentation/pages/pages_GC/home_chat.dart';
import 'package:report_it/presentation/widget/widget_info.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../widget/styles.dart';
import 'FAQinformativa_page.dart';
import '../navigation_animations.dart';

class Informativa extends StatefulWidget {
  @override
  State<Informativa> createState() => _InformativaState();
}

class _InformativaState extends State<Informativa> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        color: ThemeText.theme.backgroundColor,
        duration: const Duration(seconds: 1),
        child: ListView(
          children: [
            const WidgetInfo(
              titolo: "Informativa",
              corpo:
                  "Vuoi sapere di più sulle discriminazioni?\nEcco qui una sezione FAQ!",
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    viewportFraction: 1,
                    height: MediaQuery.of(context).size.height * 0.6,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  items: carousels.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: Colors.grey.shade200,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    i.title,
                                    style: ThemeText.titoloInoltro,
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              Image.asset(
                                i.imagePath,
                                scale: 7,
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: i.body != ''
                                      ? (Text(
                                          i.body,
                                          style: ThemeText.corpoInoltro,
                                          textAlign: TextAlign.center,
                                        ))
                                      : (ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                createRouteTo(
                                                    FAQinformativa()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            elevation: 4,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                          ),
                                          child: const Text(
                                            "Leggi di più",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ))),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: carousels.asMap().entries.map((entry) {
                return GestureDetector(
                  // onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : ThemeText.theme.primaryColor)
                            .withOpacity(_current == entry.key ? 1.0 : 0.4)),
                  ),
                );
              }).toList(),
            ),
            const WidgetInfo(
                titolo: "Contatti",
                corpo:
                    "Hai bisogno di aiuto?\nEcco qui i contatti delle forze dell'ordine!"),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: Material(
                elevation: 5,
                color: Colors.grey.shade200,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Polizia',
                              style: ThemeText.chiamataGIC,
                            ),
                            const SizedBox(width: 5),
                            Container(
                              height: 40,
                              decoration: ThemeText.bottoneChiamata,
                              child: TextButton(
                                onPressed: () async {
                                  FlutterPhoneDirectCaller.callNumber('113');
                                },
                                child: const Text(
                                  '113',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Carabinieri',
                              style: ThemeText.chiamataGIC,
                            ),
                            const SizedBox(width: 5),
                            Container(
                              height: 40,
                              decoration: ThemeText.bottoneChiamata,
                              child: TextButton(
                                onPressed: () async {
                                  FlutterPhoneDirectCaller.callNumber('112');
                                },
                                child: const Text(
                                  '112',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Guardia di Finanza',
                              style: ThemeText.chiamataGIC,
                            ),
                            const SizedBox(width: 5),
                            Container(
                              height: 40,
                              decoration: ThemeText.bottoneChiamata,
                              child: TextButton(
                                onPressed: () async {
                                  FlutterPhoneDirectCaller.callNumber('117');
                                },
                                child: const Text(
                                  '117',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const WidgetInfo(
                titolo: "Aiuto chat-bot",
                corpo: "Qualcosa non è chiaro? Prova a chiedere al chat-bot!"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: FloatingActionButton.extended(
                onPressed: (() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => HomeChat()),
                    ),
                  );
                }),
                label: Text('Avvia Chat-Bot'),
                icon: Icon(
                  Icons.android,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  List<ContentsInformation> carousels = [
    ContentsInformation(
        title: 'Discriminazione di genere',
        body:
            'La discriminazione di genere è definita dalla Direttiva 2002/73/CE relativa all\'attuazione del principio della parità di trattamento tra gli uomini e le donne per quanto riguarda l\'accesso al lavoro, alla formazione e alla promozione professionale e le condizioni di lavoro.',
        imagePath: 'assets/images/gender.png'),
    ContentsInformation(
        title: 'Discriminazione razziale',
        body:
            'Non esistono razze ma etnie diverse: ogni individuo, qualunque sia la sua origine e la sua cultura, non dev\'essere sminuito e va trattato con dignità.',
        imagePath: 'assets/images/racism.png'),
    ContentsInformation(
        title: 'Discriminazione per credo',
        body:
            'Ogni individuo è libero di scegliere il proprio credo e di parlarne apertamente, senza paura alcuna.',
        imagePath: 'assets/images/religion.png'),
    ContentsInformation(
        title: 'Discriminazione sessuale',
        body:
            'Ogni individuo è libero di amare e porre dei vincoli a chi si può amare è soltanto il residuo di una cultura retrograda.',
        imagePath: 'assets/images/sexual.png'),
    ContentsInformation(
        title: 'Discriminazione politica',
        body:
            'Ogni individuo deve essere uguale davanti alla legge, e deve poter essere libero di votare liberamente per la fazione politica di sua preferenza senza essere visto di cattivo occhio per le sue scelte; il pensiero politico di un singolo non deve prevalere su un altro',
        imagePath: 'assets/images/politics.png'),
    ContentsInformation(
        title: 'Discriminazione per disabilità',
        body:
            'Ogni individuo sofferente di una qualsiasi forma di disabilità, sia essa fisica o neurale, dev\'essere trattato con dignità e alla pari di ciascun altro individuo',
        imagePath: 'assets/images/disability.png'),
    ContentsInformation(
        title: 'Vuoi saperne di più?',
        body: '',
        imagePath: 'assets/images/report_it_megaphone_man.png'),
  ];
}

class ContentsInformation {
  String title, body, imagePath;

  ContentsInformation(
      {required this.title, required this.body, required this.imagePath});
}
