part of 'upcoming_movie_bloc.dart';

abstract class UpcomingMovieState extends Equatable {
  const UpcomingMovieState();

  @override
  List<Object> get props => [];
}

class UpcomingMovieInitial extends UpcomingMovieState {}

class UpcomingMovieLoading extends UpcomingMovieState {}

class ListUpcomingMovieLoading extends UpcomingMovieState {}

class UpcomingMovieError extends UpcomingMovieState {
  final String e;
  const UpcomingMovieError(this.e);
  @override
  List<Object> get props => [e];
}

class UpcomingMovieSuccess extends UpcomingMovieState {
  final ListMovieModel data;
  const UpcomingMovieSuccess(this.data);

  @override
  List<Object> get props => [data];
}
