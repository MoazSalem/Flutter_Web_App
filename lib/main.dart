import 'package:flutter/material.dart';
import 'package:netflix_web/screens/MoviesPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netflix Clone',
      darkTheme:ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
      ),
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
      ),
      themeMode: ThemeMode.dark,
      home: const MoviesPage(),
    );
  }
}
