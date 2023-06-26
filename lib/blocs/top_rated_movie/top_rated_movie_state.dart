part of 'top_rated_movie_bloc.dart';

abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object> get props => [];
}

class TopRatedMovieInitial extends TopRatedMovieState {}

class TopRatedMovieLoading extends TopRatedMovieState {}

class TopRatedMovieError extends TopRatedMovieState {
  final String e;
  const TopRatedMovieError(this.e);
  @override
  List<Object> get props => [e];
}

class TopRatedMovieSuccess extends TopRatedMovieState {
  final ListMovieModel data;
  const TopRatedMovieSuccess(this.data);

  @override
  List<Object> get props => [data];
}
