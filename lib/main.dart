import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() {
  runApp(const MusifyApp());
}

class MusifyApp extends StatelessWidget {
  const MusifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
