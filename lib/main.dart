import 'package:flutter/material.dart';
import 'package:games_wiki/core/inject.dart';
import 'package:games_wiki/pages/home_screen/navigation_bar.dart';

void main() {
  Injenction.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationBarController(),
    );
  }
}