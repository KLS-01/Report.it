import 'package:flutter/material.dart';

class CardImaggine extends StatelessWidget {
  const CardImaggine({super.key, this.immagine});

  final immagine;

  @override
  Widget build(BuildContext context) {
    return (immagine != null && immagine != "")
        ? Container(
            child: FadeInImage.assetNetwork(
              placeholderScale: 1.5,
              placeholder: "assets/images/MnyxU.gif",
              image: immagine,
            ),
          )
        : Column();
  }
}
