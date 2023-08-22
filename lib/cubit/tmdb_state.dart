part of 'tmdb_cubit.dart';

@immutable
abstract class TmdbState {}

class TmdbInitial extends TmdbState {}

class Start extends TmdbState {}

class GetMovies extends TmdbState {}

class SetLoading extends TmdbState {}

class Change extends TmdbState {}
