import 'package:flutter/material.dart';
import 'package:report_it/presentation/widget/styles.dart';

class WidgetInfo extends StatelessWidget {
  final String titolo;
  final String corpo;

  const WidgetInfo({super.key, required this.titolo, required this.corpo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text(
            titolo,
            style: ThemeText.titoloGIC,
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          child: Text(
            corpo,
            style: ThemeText.corpoGIC,
          ),
        )
      ],
    );
  }
}
