import 'package:flutter/material.dart';
import 'package:myproject/home_page.dart';

void main() => runApp(const SagarRideApp());

class SagarRideApp extends StatelessWidget {
  const SagarRideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes Diary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF062B43),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF087EAA),
          brightness: Brightness.dark,
          primary: const Color(0xFF16B9D4),
          secondary: const Color(0xFFFF8B35),
          tertiary: const Color(0xFFFFC857),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}
