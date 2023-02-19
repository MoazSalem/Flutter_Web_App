import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:netflix_web/screens/movies_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        }
      ),
      debugShowCheckedModeBanner: false,
      title: 'Netflix Clone',
      darkTheme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
      ),
      themeMode: ThemeMode.dark,
      home: const MoviesPage(),
    );
  }
}
