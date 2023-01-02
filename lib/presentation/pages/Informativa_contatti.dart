// ignore_for_file: prefer_const_constructors

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//CAMBIARE, QUESTO è IL ROSA PORCO DI FONDO
Color? containerColor;
List<Color> containerColors = [
  const Color(0xFFFDE1D7),
  const Color(0xFFE4EDF5),
  const Color(0xFFE7EEED),
  const Color(0xFFF4E4CE),
];

class Informativa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: containerColor ?? containerColors[0],
      duration: const Duration(seconds: 1),
      child: PageView(
        // onPageChanged: _onPageChanged,
        children: <Widget>[
          ListView(
            children: [
              PagerPageWidget_noimage(
                text: 'Informativa....',
                description: 'Hai bisogno di aiuto? Ecco qui una sezione FAQ!',
                //image: Image.asset('images/C11_Logo-png.png'), questo non si vede perché ho cambiato widget
              ),
              Card1(
                titolo: legge,
                corpo: loremIpsum,
              ),
              Card1(
                titolo: denuncia,
                corpo: loremIpsum,
              ),
              Card1(
                titolo: psicologo,
                corpo: loremIpsum,
              ),
              Card1(
                titolo: mappa,
                corpo: loremIpsum,
              ),
            ],
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
}

// WIDGET INFORMATIVA E CONTATTI CON IMMAGINE
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
