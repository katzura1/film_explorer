part of 'upcoming_movie_bloc.dart';

abstract class UpcomingMovieEvent extends Equatable {
  const UpcomingMovieEvent();

  @override
  List<Object> get props => [];
}

class UpcomingMovieGet extends UpcomingMovieEvent {}
