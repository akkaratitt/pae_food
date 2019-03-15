import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
// Explicit
  Widget nameApp = Text('Pae Food');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pae Food',
      home: nameApp,
    );
  }
}
