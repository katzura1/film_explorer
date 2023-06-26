part of 'search_movie_bloc.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

class SearchMovieInitial extends SearchMovieState {}

class SearchMovieLoading extends SearchMovieState {}

class SearchMovieError extends SearchMovieState {
  final String e;
  const SearchMovieError(this.e);
  @override
  List<Object> get props => [e];
}

class SearchMovieSuccess extends SearchMovieState {
  final ListMovieModel data;
  const SearchMovieSuccess(this.data);

  @override
  List<Object> get props => [data];
}
