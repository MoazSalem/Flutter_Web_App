import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/screens/home_page.dart';
import 'package:netflix_web/screens/movies/movies_page.dart';
import 'package:netflix_web/screens/tvShows/tv_page.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(routes: [
    GoRoute(
        path: "movies/popular",
        builder: (BuildContext context, GoRouterState state) => const MoviesPage(
              categoryIndex: 0,
              title: 'Popular',
            )),
    GoRoute(
        path: "movies/top-rated",
        builder: (BuildContext context, GoRouterState state) => const MoviesPage(
              categoryIndex: 2,
              title: 'Top Rated',
            )),
    GoRoute(
        path: "movies/now-playing",
        builder: (BuildContext context, GoRouterState state) => const MoviesPage(
              categoryIndex: 1,
              title: 'Now Playing',
            )),
    GoRoute(
        path: "movies/upcoming",
        builder: (BuildContext context, GoRouterState state) => const MoviesPage(
              categoryIndex: 3,
              title: 'Upcoming',
            )),
    GoRoute(
        path: "tv/popular",
        builder: (BuildContext context, GoRouterState state) => const TvPage(
              categoryIndex: 0,
              title: 'popular',
            )),
    GoRoute(
        path: "tv/top-rated",
        builder: (BuildContext context, GoRouterState state) => const TvPage(
              categoryIndex: 2,
              title: 'Top Rated',
            )),
    GoRoute(
        path: "tv/airing-today",
        builder: (BuildContext context, GoRouterState state) => const TvPage(
              categoryIndex: 1,
              title: 'Airing Today',
            )),
    GoRoute(
        path: "tv/on-the-air",
        builder: (BuildContext context, GoRouterState state) => const TvPage(
              categoryIndex: 3,
              title: 'On The Air',
            )),
  ], path: "/", builder: (BuildContext context, GoRouterState state) => const HomePage())
]);
