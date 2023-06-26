part of 'popular_movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class ListMovieLoading extends MovieState {}

class MovieError extends MovieState {
  final String e;
  const MovieError(this.e);
  @override
  List<Object> get props => [e];
}

class MovieSuccess extends MovieState {
  final ListMovieModel data;
  const MovieSuccess(this.data);

  @override
  List<Object> get props => [data];
}
