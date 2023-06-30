part of 'genre_movie_bloc.dart';

abstract class GenreMovieState extends Equatable {
  const GenreMovieState();

  @override
  List<Object> get props => [];
}

class GenreMovieInitial extends GenreMovieState {}

class GenreMovieLoading extends GenreMovieState {}

class GenreMovieError extends GenreMovieState {
  final String e;
  const GenreMovieError(this.e);
  @override
  List<Object> get props => [e];
}

class GenreMovieSuccess extends GenreMovieState {
  final ListMovieModel data;
  const GenreMovieSuccess(this.data);

  @override
  List<Object> get props => [data];
}
