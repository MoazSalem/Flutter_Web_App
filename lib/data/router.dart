import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/screens/home_page.dart';
import 'package:netflix_web/screens/movies/movies_page.dart';
import 'package:netflix_web/screens/movies/movie_info.dart';
import 'package:netflix_web/screens/tvShows/tv_page.dart';
import 'package:netflix_web/screens/tvShows/tv_info.dart';

import '../screens/movies/genre_page.dart';

final GoRouter router = GoRouter(initialLocation: '/', routes: [
  GoRoute(routes: [
    GoRoute(
      path: "movies/popular/:page",
      builder: (BuildContext context, GoRouterState state) => MoviesPage(
        categoryIndex: 0,
        title: 'Popular',
        page: state.params['page'],
      ),
    ),
    GoRoute(
        path: "movies/top_rated/:page",
        builder: (BuildContext context, GoRouterState state) => MoviesPage(
              categoryIndex: 2,
              title: 'Top Rated',
              page: state.params['page'],
            )),
    GoRoute(
        path: "movies/now_playing/:page",
        builder: (BuildContext context, GoRouterState state) => MoviesPage(
              categoryIndex: 1,
              title: 'Now Playing',
              page: state.params['page'],
            )),
    GoRoute(
        path: "movies/upcoming/:page",
        builder: (BuildContext context, GoRouterState state) => MoviesPage(
              categoryIndex: 3,
              title: 'Upcoming',
              page: state.params['page'],
            )),
    GoRoute(
        path: "movies/:id",
        builder: (BuildContext context, GoRouterState state) => MovieInfo(
              id: state.params['id']!,
            )),
    GoRoute(
        path: "movies/:genre/:page",
        builder: (BuildContext context, GoRouterState state) => MoviesGenrePage(
              page: state.params['page'],
              genre: state.params['genre'],
            )),
    GoRoute(
        path: "tv/popular/:page",
        builder: (BuildContext context, GoRouterState state) => TvPage(
              categoryIndex: 0,
              title: 'Popular',
              page: state.params['page'],
            )),
    GoRoute(
        path: "tv/top_rated/:page",
        builder: (BuildContext context, GoRouterState state) => TvPage(
              categoryIndex: 2,
              title: 'Top Rated',
              page: state.params['page'],
            )),
    GoRoute(
        path: "tv/airing_today/:page",
        builder: (BuildContext context, GoRouterState state) => TvPage(
              categoryIndex: 1,
              title: 'Airing Today',
              page: state.params['page'],
            )),
    GoRoute(
        path: "tv/on_the_air/:page",
        builder: (BuildContext context, GoRouterState state) => TvPage(
              categoryIndex: 3,
              title: 'On The Air',
              page: state.params['page'],
            )),
    GoRoute(
        path: "tv/:id",
        builder: (BuildContext context, GoRouterState state) => TvInfo(
              id: state.params['id']!,
            )),
  ], path: "/", builder: (BuildContext context, GoRouterState state) => const HomePage())
]);
