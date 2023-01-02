import 'package:flutter/material.dart';
import 'package:sweet_nav_bar/sweet_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SweetNavBar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SweetNaveBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SweetNaveBar extends StatefulWidget {
  const SweetNaveBar({Key? key}) : super(key: key);

  @override
  State<SweetNaveBar> createState() => _SweetNavBarState();
}

class _SweetNavBarState extends State<SweetNaveBar> {
  final List<Widget> _items = [
    const Text('Denunce'),
    const Text('Forum'),
    const Text('Mappa'),
    const Text('Psicologo'),
  ];

  int cIndex = 0;
  final iconLinearGradiant = List<Color>.from(
      [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 255, 255, 255)]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: iconLinearGradiant,
            ),
          ),
          child: Center(child: _items[cIndex])),
      bottomNavigationBar: SweetNavBar(
        paddingGradientColor: const LinearGradient(colors: [
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 255, 255, 255)
        ]),
        currentIndex: cIndex,
        paddingBackgroundColor: Color.fromARGB(255, 0, 0, 0),
        items: [
          SweetNavBarItem(
              sweetIcon: const Icon(Icons.local_police_outlined),
              sweetLabel: 'Denunce'),
          SweetNavBarItem(
              sweetIcon: const Icon(Icons.forum_outlined), sweetLabel: 'Forum'),
          SweetNavBarItem(
              sweetIcon: const Icon(Icons.navigation_outlined),
              sweetLabel: 'Mappa'),
          SweetNavBarItem(
              sweetIcon: const Icon(Icons.psychology_outlined),
              sweetLabel: 'Psicologo'),
        ],
        onTap: (index) {
          setState(() {
            cIndex = index;
          });
        },
      ),
    );
  }
}
