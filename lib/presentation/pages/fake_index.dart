import 'package:flutter/material.dart';

Color? containerColor;
List<Color> containerColors = [
  const Color(0xFFFDE1D7),
  const Color(0xFFE4EDF5),
  const Color(0xFFE7EEED),
  const Color(0xFFF4E4CE),
];

class Fake_index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: containerColor ?? containerColors[0],
    );
  }
}
