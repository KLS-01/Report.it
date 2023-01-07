import 'package:flutter/material.dart';

class ForumHome extends StatefulWidget {
  const ForumHome({super.key});

  @override
  State<ForumHome> createState() => _ForumHomeState();
}

class _ForumHomeState extends State<ForumHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(255, 254, 248, 1),
          appBar: AppBar(
            elevation: 5,
            toolbarHeight: 0,
            backgroundColor: Theme.of(context).backgroundColor,
            bottom: const TabBar(
              labelColor: Color.fromRGBO(219, 29, 69, 1),
              indicatorColor: Color.fromRGBO(219, 29, 69, 1),
              tabs: [
                Tab(
                  child: Text("tutte le discussioni"),
                ),
                Tab(
                  child: Text("le tue discussioni"),
                )
              ],
            ),
          ),
          body: TabBarView(children: [ListView(), ListView()]),
        ),
      ),
    );
  }
}
