import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:tmdb_web/bloc/nex_bloc.dart';
import 'package:url_strategy/url_strategy.dart';
import 'data/router.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NexBloc(),
      child: MaterialApp.router(
          builder: (context, child) => ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: [
                  const Breakpoint(start: 0, end: 600),
                  const Breakpoint(start: 600, end: 800),
                  const Breakpoint(start: 800, end: 1200),
                  const Breakpoint(start: 1000, end: 1600),
                ],
              ),
          scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          }),
          debugShowCheckedModeBanner: false,
          title: 'TMDB Web',
          darkTheme: ThemeData(
            useMaterial3: true,
            primaryColor: const Color(0xff039ac3),
            brightness: Brightness.dark,
            indicatorColor: Colors.white,
            canvasColor: Colors.black,
            appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
            scrollbarTheme: const ScrollbarThemeData().copyWith(
                thumbVisibility: MaterialStateProperty.all(true),
                thumbColor: MaterialStateProperty.all(const Color(0xff039ac3).withOpacity(0.5))),
          ),
          themeMode: ThemeMode.dark,
          routerConfig: router),
    );
  }
}
