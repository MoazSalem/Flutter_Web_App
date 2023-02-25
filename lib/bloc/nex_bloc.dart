// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_web/models/tv.dart';
import '../data/end_points.dart';
import '../models/movies.dart';
import '../services/movies_service.dart';
import '../services/tv_service.dart';

part 'nex_event.dart';

part 'nex_state.dart';

class NexBloc extends Bloc<NexEvent, NexState> {
  List<String> movieCategories = ["popular", "now_playing", "top_rated", "upcoming"];
  List<String> tvCategories = ["popular", "airing_today", "top_rated", "on_the_air"];
  List<Movie> moviesList = [];
  List tvShowsList = [];

  // For Some Reason Flutter doesn't wait for the late initialization in web so just initialize it
  Movie movie = emptyMovie;
  TvShow show = emptyShow;

  static NexBloc get(context) => BlocProvider.of(context);

  NexBloc() : super(NexInitial()) {
    on<NexEvent>((event, emit) {});
  }

  getMovies({required int page, required int categoryIndex}) async {
    moviesList = await MoviesService().getMovies(
        page: page, endPoint: getEndPoint(category: movieCategories[categoryIndex], typeIndex: 0));
    emit(GetMovies());
  }

  getMovie({required int id}) async {
    movie = moviesList.isNotEmpty
        ? moviesList.firstWhere((movie) => movie.id == id)
        : await MoviesService().getMovie(id: id);
    emit(GetMovies());
  }

  getShows({required int page, required int categoryIndex}) async {
    tvShowsList = await TVService().getShows(
        page: page, endPoint: getEndPoint(category: tvCategories[categoryIndex], typeIndex: 1));
    emit(GetMovies());
  }

  getShow({required int id}) async {
    show = tvShowsList.isNotEmpty
        ? tvShowsList.firstWhere((show) => show.id == id)
        : await TVService().getShow(id: id);
    emit(GetMovies());
  }
}
