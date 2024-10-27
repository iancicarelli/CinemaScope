import 'package:flutter/material.dart';
import 'pages/HomePage.dart';
import 'pages/ButtomNavBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue[900],
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue[900],
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo[400],
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const ButtomNavBar(),
    );
  }
}


