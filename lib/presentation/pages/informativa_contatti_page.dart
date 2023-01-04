import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:report_it/presentation/widget/widget_info.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Informativa extends StatefulWidget {
  @override
  State<Informativa> createState() => _InformativaState();
}

class _InformativaState extends State<Informativa> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: const Color.fromRGBO(255, 254, 248, 1),
      duration: const Duration(seconds: 1),
      child: ListView(
        children: [
          const WidgetInfo(
            titolo: "Informativa",
            corpo: "Hai bisogno di aiuto?\nEcco qui una sezione FAQ!",
          ),
          const SizedBox(
            height: 20,
          ),
          CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: false,
              viewportFraction: 1,
              height: MediaQuery.of(context).size.height * 0.55,
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
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color.fromARGB(255, 225, 225, 225)),
                    child: Column(
                      children: [
                        Text(
                          i.title,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Image.asset(
                          i.imagePath,
                          scale: 7,
                        ),
                        Text(
                          i.body,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
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
                              : const Color.fromRGBO(219, 29, 69, 1))
                          .withOpacity(_current == entry.key ? 1.0 : 0.4)),
                ),
              );
            }).toList(),
          ),

          //per Leo: ho creato WidgetInfo come widget (lo trovi nella cartella widget) per creare i due box in cui
          //scrivere la parte iniziale e finale (il testo) della pagina. Nel secondo widget, cioè questo sotto,
          //stavo implementando la chiamata, che vedi come FlutterPhoneDirectCaller. Se avvii così il codice,
          //vedi che la chiamata funziona, solo che ti prenderà come cliccabile tutto il rigo di Text e non solo il
          //pezzettino in cui c'è la scritta, stavo cercando di correggere questo
          // e volevo riempire i caroselli + vedere come aggiungere il tasto sull'ultimo Contents Information,
          // a cui va collegata una pagina molto easy di solo testo con le varie FAQ di cui posso occuparmene io,
          //quando arrivi a questo punto scrivimi che ci coordiniamo
          //Ci sono arrivato donnola :3

          const WidgetInfo(titolo: "Contatti", corpo: ""),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            child: Material(
              elevation: 10,
              color: const Color.fromARGB(255, 225, 225, 225),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Polizia',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 5),
                        TextButton(
                          onPressed: () async {
                            FlutterPhoneDirectCaller.callNumber('113');
                          },
                          child: const Text(
                            '113',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Carabinieri',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 5),
                        TextButton(
                          onPressed: () async {
                            FlutterPhoneDirectCaller.callNumber('112');
                          },
                          child: const Text(
                            '112',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Guardia di Finanza',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 5),
                        TextButton(
                          onPressed: () async {
                            FlutterPhoneDirectCaller.callNumber('117');
                          },
                          child: const Text(
                            '117',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Samaritas',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 5),
                        TextButton(
                          onPressed: () async {
                            FlutterPhoneDirectCaller.callNumber('06 77208977');
                          },
                          child: const Text(
                            '06 77208977',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<ContentsInformation> carousels = [
    ContentsInformation(
        title: 'Race Discrimination',
        body:
            'Non esistono razze ma etnie diverse: ogni individuo, qualunque sia la sua origine e la sua cultura, non dev\'essere sminuito e va trattato con dignità.',
        imagePath: 'assets/images/racism.png'),
    ContentsInformation(
        title: 'Religious Discrimination',
        body:
            'Ogni individuo è libero di scegliere il proprio credo e di parlarne apertamente, senza paura alcuna.',
        imagePath: 'assets/images/religion.png'),
    ContentsInformation(
        title: 'Sexual Discrimination',
        body:
            'Ogni individuo è libero di amare e porre dei vincoli a chi si può amare è soltanto il residuo di una cultura retrograda.',
        imagePath: 'assets/images/sexual.png'),
    ContentsInformation(
        title: 'Political Discrimination',
        body:
            'Ogni individuo deve essere uguale davanti alla legge, e deve poter essere libero di votare liberamente per la fazione politica di sua preferenza senza essere visto di cattivo occhio per le sue scelte; il pensiero politico di un singolo non deve prevalere su un altro',
        imagePath: 'assets/images/politics.png'),
    ContentsInformation(
        title: 'Disability Discrimination',
        body:
            'Ogni individuo sofferente di una qualsiasi forma di disabilità, sia essa fisica o neurale, dev\'essere trattato con dignità e alla pari di ciascun altro individuo',
        imagePath: 'assets/images/disability.png'),
  ];
}

class ContentsInformation {
  String title, body, imagePath;

  ContentsInformation(
      {required this.title, required this.body, required this.imagePath});
}
