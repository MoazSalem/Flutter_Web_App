import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_web/screens/home_page.dart';
import 'package:tmdb_web/screens/movies/movies_page.dart';
import 'package:tmdb_web/screens/movies/movie_info.dart';
import 'package:tmdb_web/screens/search_page.dart';
import 'package:tmdb_web/screens/tvShows/main_page.dart';
import 'package:tmdb_web/screens/tvShows/tv_page.dart';
import 'package:tmdb_web/screens/tvShows/tv_info.dart';
import 'package:tmdb_web/screens/movies/main_page.dart';

final GoRouter router = GoRouter(initialLocation: '/', routes: [
  GoRoute(routes: [
    GoRoute(
        path: "movies",
        builder: (BuildContext context, GoRouterState state) => const MainMovies(),
        routes: [
          GoRoute(
              path: "search",
              builder: (BuildContext context, GoRouterState state) => const SearchPage(
                    movie: true,
                  )),
          GoRoute(
              path: ":genre/:page",
              builder: (BuildContext context, GoRouterState state) => MoviesPage(
                    page: state.pathParameters['page']!,
                    category: state.pathParameters['genre']!,
                  )),
          GoRoute(
              path: ":id",
              builder: (BuildContext context, GoRouterState state) => MovieInfo(
                    id: state.pathParameters['id']!,
                  )),
        ]),
    GoRoute(
        path: "tv",
        builder: (BuildContext context, GoRouterState state) => const MainTv(),
        routes: [
          GoRoute(
              path: "search",
              builder: (BuildContext context, GoRouterState state) => const SearchPage(
                    movie: false,
                  )),
          GoRoute(
              path: ":genre/:page",
              builder: (BuildContext context, GoRouterState state) => TvPage(
                    page: state.pathParameters['page']!,
                    category: state.pathParameters['genre']!,
                  )),
          GoRoute(
              path: ":id",
              builder: (BuildContext context, GoRouterState state) => TvInfo(
                    id: state.pathParameters['id']!,
                  )),
        ]),
  ], path: "/", builder: (BuildContext context, GoRouterState state) => const HomePage())
]);
