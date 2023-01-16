import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:report_it/domain/entity/discussione_entity.dart';
import 'package:report_it/domain/repository/forum_service.dart';

class like extends StatefulWidget {
  like({
    super.key,
    required this.discussione,
    required this.callback,
    required this.flag,
    required this.numero,
  });
  Discussione discussione;
  Function callback;
  bool flag;
  int numero;

  @override
  State<like> createState() => _likeState();
}

class _likeState extends State<like> {
  User? utente = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.numero.toString()),
        Material(
          color: Colors.transparent,
          child: !widget.flag
              ? InkWell(
                  onTap: () {
                    setState(() {
                      widget.flag = !widget.flag;
                      widget.numero += 1;
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
                      widget.flag = !widget.flag;
                      widget.numero -= 1;
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
