import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widget/styles.dart';

class FAQinformativa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: Theme.of(context).backgroundColor,
      duration: const Duration(seconds: 1),
      child: PageView(
        children: <Widget>[
          ListView(
            children: [
              const PagerPageWidget_noimage(
                text: 'Sezione FAQ',
                description:
                    'FAQ sta per "frequently asked questions", cioè le domande maggiormente chieste!',
              ),
              Card1(
                titolo: titolo1,
                corpo: corpo1,
              ),
              Card1(
                titolo: titolo2,
                corpo: corpo2,
              ),
              Card1(
                titolo: titolo3,
                corpo: corpo3,
              ),
              Card1(
                titolo: titolo4,
                corpo: corpo4,
              ),
            ],
          ),
        ],
      ),
    );
  }

  final titolo1 = "Quali sono le leggi anti-discriminazione?";
  final corpo1 =
      "La legge 25 giugno 1993, n. 205 è un atto legislativo della Repubblica Italiana che sanziona e condanna frasi, gesti, azioni e slogan aventi per scopo l’incitamento all'odio, l'incitamento alla violenza, la discriminazione e la violenza per motivi razziali, etnici, religiosi o nazionali. La legge punisce anche l'utilizzo di emblemi o simboli. Emanata con il decreto legge 26 aprile 1993 n. 122 - convertito con modificazioni in legge 25 giugno 1993, n. 205 - è nota come legge Mancino, dal nome dell'allora Ministro dell'Interno che ne fu proponente (Nicola Mancino). Approvata durante il Governo Ciampi, essa è oggi il principale strumento legislativo che l'ordinamento italiano offre per la repressione dei crimini d'odio e dell’incitamento all'odio.";

  final titolo2 = 'In quali sanzioni incorre il denunciato?';
  final corpo2 =
      'L\'art. 1 ("Discriminazione, odio o violenza per motivi razziali, etnici, nazionali o religiosi") dispone quanto segue: "Salvo che il fatto costituisca più grave reato, [...] è punito: a) con la reclusione fino a un anno e sei mesi o con la multa fino a 6.000 euro chi propaganda idee fondate sulla superiorità o sull\'odio razziale o etnico, ovvero istiga a commettere o commette atti di discriminazione per motivi razziali, etnici, nazionali o religiosi; b) con la reclusione da sei mesi a quattro anni chi, in qualsiasi modo, incita a commettere o commette violenza o atti di provocazione alla violenza per motivi razziali, etnici, nazionali o religiosi.';

  final titolo3 = 'Posso inoltrare una denuncia anonima?';
  final corpo3 =
      'Ad oggi non è consentito dalla legge italiana l\'inoltro di una denuncia in formato anonimo.';

  final titolo4 = ' Cos\'è il CUP?';
  final corpo4 =
      'Il servizio on-line del Centro Unico di Prenotazione consente ai cittadini campani di prenotare visite specialistiche e di diagnostica strumentale presso gli Enti di Regione aderenti al servizio, di gestire i propri appuntamenti e pagare direttamente tramite MyPay le prestazioni prenotate. Per effettuare una nuova prenotazione è necessario disporre del Numero di Ricetta Elettronica (NRE) presente in tutte le ricette elettroniche dematerializzate.';
}

//widget
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

// widget varie card
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
                header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      titolo,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                collapsed: Text(
                  corpo,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Text(
                  corpo,
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
