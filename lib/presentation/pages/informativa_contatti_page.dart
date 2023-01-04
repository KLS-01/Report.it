// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          PagerPageWidget_noimage(
            text: 'Informativa....',
            description: 'Hai bisogno di aiuto? Ecco qui una sezione FAQ!',
            //image: Image.asset('images/C11_Logo-png.png'), questo non si vede perché ho cambiato widget
          ),
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
                            style: TextStyle(fontSize: 16.0),
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
          PagerPageWidget(
            text: '....e Contatti!',
            description: 'Polizia 113 \nCarabinieri 112\n Pronto Soccorso 118',
            image: Image.asset('assets/images/support.png'),
          ),
        ],
      ),
    );
  }

  final loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  final legge = "Quali sono le leggi anti-discriminazione?";

  final denuncia = 'Come posso inoltrare una denuncia?';

  final psicologo = 'Come posso prenotare una visita psicologica?';

  final mappa = 'Come posso trovare la caserma o ospedale più vicino a me?';

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

// WIDGET INFORMATIVA E CONTATTI CON IMMAGINE
class ContentsInformation {
  String title, body, imagePath;

  ContentsInformation(
      {required this.title, required this.body, required this.imagePath});
}

class PagerPageWidget extends StatelessWidget {
  final String? text;
  final String? description;
  final Image? image;
  final TextStyle titleStyle =
      const TextStyle(fontSize: 40, fontFamily: 'SourceSerifPro');
  final TextStyle subtitleStyle = const TextStyle(
    fontSize: 20,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w200,
  );

  const PagerPageWidget({
    Key? key,
    this.text,
    this.description,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: SafeArea(
        child: OrientationBuilder(builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _portraitWidget()
              : _horizontalWidget(context);
        }),
      ),
    );
  }

  Widget _portraitWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(text!, style: titleStyle),
            const SizedBox(height: 16),
            Text(description!, style: subtitleStyle),
          ],
        ),
        image!
      ],
    );
  }

  Widget _horizontalWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(text!, style: titleStyle),
              Text(description!, style: subtitleStyle),
            ],
          ),
        ),
        Expanded(child: image!)
      ],
    );
  }
}

//widget informativa e contatti SENZA immagine
class PagerPageWidget_noimage extends StatelessWidget {
  final String? text;
  final String? description;
  final TextStyle titleStyle =
      const TextStyle(fontSize: 40, fontFamily: 'SourceSerifPro');
  final TextStyle subtitleStyle = const TextStyle(
    fontSize: 20,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w200,
  );

  const PagerPageWidget_noimage({
    Key? key,
    this.text,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: SafeArea(
        child: OrientationBuilder(builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _portraitWidget()
              : _horizontalWidget(context);
        }),
      ),
    );
  }

  Widget _portraitWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(text!, style: titleStyle),
            const SizedBox(height: 16),
            Text(description!, style: subtitleStyle),
          ],
        ),
      ],
    );
  }

  Widget _horizontalWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(text!, style: titleStyle),
              Text(description!, style: subtitleStyle),
            ],
          ),
        ),
      ],
    );
  }
}
// inizia la FAQ UI (classi)

class Card1 extends StatelessWidget {
  const Card1({super.key, required this.titolo, required this.corpo});
  final String titolo;
  final String corpo;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                // ignore: prefer_const_constructors
                header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      titolo,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                // ignore: prefer_const_constructors
                collapsed: Text(
                  corpo,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var _ in Iterable.generate(5))
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            corpo,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          )),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
