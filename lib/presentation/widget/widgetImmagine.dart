import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CardImaggine extends StatelessWidget {
  const CardImaggine({super.key, this.immagine});

  final immagine;

  @override
  Widget build(BuildContext context) {
    return (immagine != null && immagine != "")
        ? Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(immagine),
              ),
            ),
            child: Image.network(immagine),
          )
        : Column();
  }
}
