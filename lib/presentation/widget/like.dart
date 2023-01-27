import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:report_it/domain/entity/entity_GF/discussione_entity.dart';
import 'package:report_it/domain/repository/forum_controller.dart';

// ignore: must_be_immutable
class like extends StatefulWidget {
  like({
    super.key,
    required this.discussione,
    required this.callback,
  });
  Discussione discussione;
  Function callback;

  @override
  State<like> createState() => _likeState();
}

class _likeState extends State<like> {
  User? utente = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var numero = widget.discussione.listaSostegno;
    return Row(
      children: [
        Text(numero.length.toString()),
        Material(
          color: Colors.transparent,
          child: !numero.contains(utente!.uid)
              ? InkWell(
                  onTap: () {
                    setState(() {
                      numero.add(utente!.uid);
                    });
                    ForumService().sostieniDiscusione(
                      widget.discussione.id!,
                      utente!.uid,
                    );
                  },
                  child: const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.red,
                    size: 30,
                  ),
                )
              : InkWell(
                  onTap: () {
                    ForumService().desostieniDiscusione(
                      widget.discussione.id!,
                      utente!.uid,
                    );
                    setState(() {
                      numero.remove(utente!.uid);
                    });
                  },
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
        ),
      ],
    );
  }
}
