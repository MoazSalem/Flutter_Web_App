import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_web/screens/home_page.dart';
import 'package:netflix_web/screens/movies/movies_page.dart';
import 'package:netflix_web/screens/movies/movie_info.dart';
import 'package:netflix_web/screens/tvShows/main_page.dart';
import 'package:netflix_web/screens/tvShows/tv_page.dart';
import 'package:netflix_web/screens/tvShows/tv_info.dart';
import 'package:netflix_web/screens/movies/genre_page.dart';
import 'package:netflix_web/screens/movies/main_page.dart';

final GoRouter router = GoRouter(initialLocation: '/', routes: [
  GoRoute(routes: [
    GoRoute(
        path: "movies",
        builder: (BuildContext context, GoRouterState state) => const MainMovies(),
        routes: [
          GoRoute(
              path: "categories/:genre/:page",
              builder: (BuildContext context, GoRouterState state) => MoviesGenrePage(
                    page: state.params['page'],
                    genre: state.params['genre'],
                  )),
          GoRoute(
            path: "popular/:page",
            builder: (BuildContext context, GoRouterState state) => MoviesPage(
              categoryIndex: 0,
              title: 'Popular',
              page: state.params['page'],
            ),
          ),
          GoRoute(
              path: "top_rated/:page",
              builder: (BuildContext context, GoRouterState state) => MoviesPage(
                    categoryIndex: 1,
                    title: 'Top Rated',
                    page: state.params['page'],
                  )),
          GoRoute(
              path: "now_playing/:page",
              builder: (BuildContext context, GoRouterState state) => MoviesPage(
                    categoryIndex: 2,
                    title: 'Now Playing',
                    page: state.params['page'],
                  )),
          GoRoute(
              path: "upcoming/:page",
              builder: (BuildContext context, GoRouterState state) => MoviesPage(
                    categoryIndex: 3,
                    title: 'Upcoming',
                    page: state.params['page'],
                  )),
          GoRoute(
              path: ":id",
              builder: (BuildContext context, GoRouterState state) => MovieInfo(
                    id: state.params['id']!,
                  )),
        ]),
    GoRoute(
        path: "tv",
        builder: (BuildContext context, GoRouterState state) => const MainTv(),
        routes: [
          GoRoute(
              path: "popular/:page",
              builder: (BuildContext context, GoRouterState state) => TvPage(
                    categoryIndex: 0,
                    title: 'Popular',
                    page: state.params['page'],
                  )),
          GoRoute(
              path: "top_rated/:page",
              builder: (BuildContext context, GoRouterState state) => TvPage(
                    categoryIndex: 1,
                    title: 'Top Rated',
                    page: state.params['page'],
                  )),
          GoRoute(
              path: "airing_today/:page",
              builder: (BuildContext context, GoRouterState state) => TvPage(
                    categoryIndex: 2,
                    title: 'Airing Today',
                    page: state.params['page'],
                  )),
          GoRoute(
              path: "on_the_air/:page",
              builder: (BuildContext context, GoRouterState state) => TvPage(
                    categoryIndex: 3,
                    title: 'On The Air',
                    page: state.params['page'],
                  )),
          GoRoute(
              path: ":id",
              builder: (BuildContext context, GoRouterState state) => TvInfo(
                    id: state.params['id']!,
                  )),
        ]),
  ], path: "/", builder: (BuildContext context, GoRouterState state) => const HomePage())
]);
