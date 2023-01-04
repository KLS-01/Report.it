import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:report_it/presentation/widget/widget_uno.dart';
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
      color: Color.fromRGBO(255, 254, 248, 1),
      duration: const Duration(seconds: 1),
      child: ListView(
        children: [
          WidgetInfo(
              titolo: "Informativa...",
              corpo: "Hai bisogno di aiuto? Ecco qui una sezione FAQ!"),
          CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: false,
              viewportFraction: 1,
              height: MediaQuery.of(context).size.height * 0.35,
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
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color.fromARGB(255, 246, 208, 97)),
                      child: Column(
                        children: [
                          Text(
                            '${i.title}',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Image.asset(
                            i.imagePath,
                            scale: 7,
                          ),
                          Text(
                            '${i.title}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ));
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
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Color.fromRGBO(219, 29, 69, 1))
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

          WidgetInfo(titolo: "....E contatti!", corpo: ""),
          Material(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: InkWell(
              onTap: () async {
                //FlutterPhoneDirectCaller.callNumber("");
              },
              child: Text('Carabinieri 118'),
            ),
          ),
          Container(
            child: Image.asset('assets/images/support.png'),
          )
        ],
      ),
    );
  }

  List<ContentsInformation> carousels = [
    ContentsInformation(
        title: 'title1',
        body: 'testo1',
        imagePath: 'assets/images/flutter1.png'),
    ContentsInformation(
        title: 'title2',
        body: 'testo2',
        imagePath: 'assets/images/flutter1.png'),
    ContentsInformation(
        title: 'title3',
        body: 'testo3',
        imagePath: 'assets/images/flutter1.png'),
    ContentsInformation(
        title: 'title4',
        body: 'testo4',
        imagePath: 'assets/images/flutter1.png'),
    ContentsInformation(
        title: 'title5',
        body: 'testo5',
        imagePath: 'assets/images/flutter1.png'),
  ];
}

class ContentsInformation {
  String title, body, imagePath;

  ContentsInformation(
      {required this.title, required this.body, required this.imagePath});
}
