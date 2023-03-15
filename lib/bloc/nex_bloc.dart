// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_web/data/categories.dart';
import 'package:netflix_web/models/cast.dart';
import 'package:netflix_web/models/movies.dart';
import 'package:netflix_web/models/reviews.dart';
import 'package:netflix_web/models/tv.dart';
import 'package:netflix_web/models/popular.dart';
import 'package:netflix_web/data/end_points.dart';
import 'package:netflix_web/services/movies_service.dart';
import 'package:netflix_web/services/tv_service.dart';
import 'package:netflix_web/services/popular.dart';

part 'nex_event.dart';

part 'nex_state.dart';

class NexBloc extends Bloc<NexEvent, NexState> {
  List<String> movieCategories = ["popular", "now_playing", "top_rated", "upcoming"];
  List<String> tvCategories = ["popular", "airing_today", "top_rated", "on_the_air"];
  List<String> categoriesNames = moviesCategoriesN;
  List<Movie> searchedMovies = [];
  List<TvShow> searchedShows = [];
  List<Results> popular = [];
  Map<int, List<Movie>> allMoviesList = {};
  Map<int, List<Movie>> genreMoviesList = {};
  Map<int, List<TvShow>> allTvShowsList = {};

  // For Some Reason Flutter doesn't wait for the late initialization in web so just initialize it
  Movie movie = emptyMovie;
  TvShow show = emptyShow;
  List<Reviews> reviews = [];
  List<Cast> casts = [];

  static NexBloc get(context) => BlocProvider.of(context);

  NexBloc() : super(NexInitial()) {
    on<NexEvent>((event, emit) {});
  }

  getPopular() async {
    popular = await PopularService().getPopular();
    emit(GetMovies());
  }

  getMoviesGenre({required int page, required String genre}) async {
    genreMoviesList[page] = await MoviesService().getGenre(page: page, genre: genre);
    emit(GetMovies());
  }

  getMovies({required int page, required int categoryIndex}) async {
    allMoviesList[page] = await MoviesService().getMovies(
        page: page, endPoint: getEndPoint(category: movieCategories[categoryIndex], typeIndex: 0));
    emit(GetMovies());
  }

  getMovie({required int id}) async {
    casts = await MoviesService().getCast(id: id);
    movie = await MoviesService().getMovie(id: id);
    emit(GetMovies());
  }

  searchMovies({required String query}) async {
    searchedMovies = await MoviesService().searchMovies(query: query);
    emit(GetMovies());
  }

  getShows({required int page, required int categoryIndex}) async {
    allTvShowsList[page] = await TVService().getShows(
        page: page, endPoint: getEndPoint(category: tvCategories[categoryIndex], typeIndex: 1));
    emit(GetMovies());
  }

  getShow({required int id}) async {
    show = await TVService().getShow(id: id);
    emit(GetMovies());
  }

  searchShows({required String query}) async {
    searchedShows = await TVService().searchShows(query: query);
    emit(GetMovies());
  }
}
