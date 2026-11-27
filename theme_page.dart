import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          brightness: Brightness.light,
        ),
        brightness: Brightness.light,
      ),

      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
      ),

      themeMode: isOn ? ThemeMode.dark : ThemeMode.light,

      home: Scaffold(
        appBar: AppBar(
          title: const Text('Student Page'),
          centerTitle: true,
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isOn = !isOn;
                });
              },
              child: Text(isOn ? '☀️' : '🌙'),
            ),
          ],
        ),
      ),
    );
  }
}
