import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FAQinformativa extends StatelessWidget {
  const FAQinformativa({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: const Color.fromRGBO(255, 254, 248, 1),
      duration: const Duration(seconds: 1),
      child: ListView(children: [
        Text(
          'FAQ',
          style: Theme.of(context).textTheme.headline1,
        ),
      ]),
    );
  }
}
