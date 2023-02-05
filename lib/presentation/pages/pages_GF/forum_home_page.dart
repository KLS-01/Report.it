// ignore_for_file: unnecessary_const
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:report_it/domain/repository/forum_controller.dart';
import 'package:report_it/presentation/pages/pages_GF/form_crea_discussione.dart';
import 'package:report_it/presentation/widget/crealista.dart';
import 'package:report_it/presentation/widget/styles.dart';

class ForumHome extends StatefulWidget {
  const ForumHome({super.key});

  @override
  State<ForumHome> createState() => _ForumHomeState();
}

class _ForumHomeState extends State<ForumHome> {
  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum', style: ThemeText.titoloSezione),
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Theme.of(context).backgroundColor,
            bottom: const TabBar(
              labelColor: Color.fromRGBO(219, 29, 69, 1),
              indicatorColor: Color.fromRGBO(219, 29, 69, 1),
              tabs: [
                Tab(
                  child:
                      Text("Tutte le discussioni", style: ThemeText.titoloTab),
                ),
                Tab(
                  child: Text("Le tue discussioni", style: ThemeText.titoloTab),
                )
              ],
            ),
          ),
          body: TabBarView(children: [
            crealista(
              list: ForumService.PrendiTutte(),
              Callback: callback,
            ),
            crealista(
              list: ForumService().Prendiutente(),
              Callback: callback,
            )
          ]),
          floatingActionButton: !keyboardIsOpen
              ? FloatingActionButton.extended(
                  label: const Text("Pubblica"),
                  heroTag: null,
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        //pisnelo
                        pageBuilder: (_, __, ___) => const ForumForm(),
                        transitionDuration: const Duration(seconds: 0),
                        transitionsBuilder: (_, a, __, c) =>
                            FadeTransition(opacity: a, child: c),
                      ),
                    ).then((value) {
                      ForumService().AggiornaLista();
                      setState(() {});
                    });
                    //
                  },
                  backgroundColor: ThemeText.theme.primaryColor,
                )
              : Container(),
        ),
      ),
    );
  }
}
