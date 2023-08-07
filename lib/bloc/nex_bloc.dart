// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_web/data/categories.dart';
import 'package:tmdb_web/models/cast.dart';
import 'package:tmdb_web/models/movies.dart';
import 'package:tmdb_web/models/reviews.dart';
import 'package:tmdb_web/models/tv.dart';
import 'package:tmdb_web/models/popular.dart';
import 'package:tmdb_web/data/end_points.dart';
import 'package:tmdb_web/models/videos.dart';
import 'package:tmdb_web/services/movies_service.dart';
import 'package:tmdb_web/services/tv_service.dart';
import 'package:tmdb_web/services/popular.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

part 'nex_event.dart';

part 'nex_state.dart';

class NexBloc extends Bloc<NexEvent, NexState> {
  List<String> moviesGenres = moviesCategoriesN;
  List<String> tvGenres = tvCategoriesN;
  List<Movie> searchedMovies = [];
  List<TvShows> searchedShows = [];
  List<Results> popular = [];
  List<Movie> moviesList = [];
  List<TvShows> tvShowsList = [];

  // For Some Reason Flutter doesn't wait for the late initialization in web so just initialize it
  Movie movie = emptyMovie;
  TvShows show = TvShows();

  List<Results> suggestions = [];
  List<Results> similar = [];
  List<Reviews> reviews = [];
  List<Cast> casts = [];
  Video trailer = emptyVideo;
  late YoutubePlayerController videoController;

  static NexBloc get(context) => BlocProvider.of(context);

  NexBloc() : super(NexInitial()) {
    on<NexEvent>((event, emit) {});
  }

  getPopular() async {
    popular = await PopularService().getPopular();
    emit(GetMovies());
  }

  getMoviesGenre({required int page, required int genre}) async {
    moviesList = await MoviesService().getGenre(page: page, genre: genre);
    emit(GetMovies());
  }

  getMovies({required int page, required String category}) async {
    moviesList = await MoviesService()
        .getMovies(page: page, endPoint: getEndPoint(category: category, typeIndex: 0));
    emit(GetMovies());
  }

  getMovie({required int id}) async {
    movie = await MoviesService().getMovie(id: id);
    trailer = await MoviesService().getVideos(id: id);
    casts = await MoviesService().getCast(id: id);
    suggestions = await MoviesService().getSuggestions(id: id);
    similar = await MoviesService().getSuggestions(id: id, type: 1);
    await getMovieReviews(pageNum: 1, id: id);
    await videoController.cueVideoById(videoId: trailer.key!);
    emit(GetMovies());
  }

  getMovieReviews({required int id, required int pageNum}) async {
    reviews = await MoviesService().getReviews(id: id, pageNum: pageNum);
    emit(GetMovies());
  }

  searchMovies({required String query}) async {
    searchedMovies = await MoviesService().searchMovies(query: query);
    emit(GetMovies());
  }

  getShows({required int page, required String category}) async {
    tvShowsList = await TVService()
        .getShows(page: page, endPoint: getEndPoint(category: category, typeIndex: 1));
    emit(GetMovies());
  }

  getShow({required int id}) async {
    show = await TVService().getShow(id: id);
    trailer = await TVService().getVideos(id: id);
    casts = await TVService().getCast(id: id);
    suggestions = await TVService().getSuggestions(id: id);
    similar = await TVService().getSuggestions(id: id, type: 1);
    await getTvReviews(pageNum: 1, id: id);
    await videoController.cueVideoById(videoId: trailer.key!);
    emit(GetMovies());
  }

  getTvReviews({required int id, required int pageNum}) async {
    reviews = await TVService().getReviews(id: id, pageNum: pageNum);
    emit(GetMovies());
  }

  searchShows({required String query}) async {
    searchedShows = await TVService().searchShows(query: query);
    emit(GetMovies());
  }

  getTvsGenre({required int page, required int genre}) async {
    tvShowsList = await TVService().getGenre(page: page, genre: genre);
    emit(GetMovies());
  }

  onChanges() {
    emit(Change());
  }
}
