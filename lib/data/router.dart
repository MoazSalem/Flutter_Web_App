import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/screens/tvShows/airing_today_page.dart';
import 'package:netflix_web/screens/tvShows/on_the_air_page.dart';
import '../screens/home_page.dart';
import '../screens/movies/now_playing_page.dart';
import '../screens/movies/popular_page.dart';
import '../screens/movies/top_rated_page.dart';
import '../screens/movies/upcoming_page.dart';
import '../screens/tvShows/popular_page.dart';
import '../screens/tvShows/top_rated_page.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(routes: [
    GoRoute(
        path: "movies/popular",
        builder: (BuildContext context, GoRouterState state) => const PopularPage()),
    GoRoute(
        path: "movies/top-rated",
        builder: (BuildContext context, GoRouterState state) => const TopRatedPage()),
    GoRoute(
        path: "movies/now-playing",
        builder: (BuildContext context, GoRouterState state) => const NowPlayingPage()),
    GoRoute(
        path: "movies/upcoming",
        builder: (BuildContext context, GoRouterState state) => const UpcomingPage()),
    GoRoute(
        path: "tv/popular",
        builder: (BuildContext context, GoRouterState state) => const PopularTPage()),
    GoRoute(
        path: "tv/top-rated",
        builder: (BuildContext context, GoRouterState state) => const TopRatedTPage()),
    GoRoute(
        path: "tv/airing-today",
        builder: (BuildContext context, GoRouterState state) => const AiringTodayPage()),
    GoRoute(
        path: "tv/on-the-air",
        builder: (BuildContext context, GoRouterState state) => const OnTheAirPage()),
  ], path: "/", builder: (BuildContext context, GoRouterState state) => const HomePage())
]);
