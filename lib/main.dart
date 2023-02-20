import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix_web/screens/movies/popular_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown
      }),
      debugShowCheckedModeBanner: false,
      title: 'Netflix Clone',
      darkTheme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.deepPurpleAccent,
          brightness: Brightness.dark,
          indicatorColor: Colors.white,
          canvasColor: Colors.black,
          appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light)),
      themeMode: ThemeMode.dark,
      home: const PopularPage(),
    );
  }
}
