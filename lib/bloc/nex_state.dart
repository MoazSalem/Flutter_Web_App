part of 'nex_bloc.dart';

@immutable
abstract class NexState {}

class NexInitial extends NexState {}

class Start extends NexState {}

class GetMovies extends NexState {}

class SetLoading extends NexState {}
