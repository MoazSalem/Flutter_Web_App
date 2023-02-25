import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_web/bloc/nex_bloc.dart';
import 'package:url_strategy/url_strategy.dart';
import 'data/router.dart';

void main() {
  //setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NexBloc(),
      child: MaterialApp.router(
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
            appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
            scrollbarTheme: const ScrollbarThemeData().copyWith(
                thumbVisibility: MaterialStateProperty.all(true),
                thumbColor: MaterialStateProperty.all(Colors.deepPurpleAccent.withOpacity(0.8))),
          ),
          themeMode: ThemeMode.dark,
          routerConfig: router),
    );
  }
}
