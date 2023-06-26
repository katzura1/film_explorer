part of 'now_playing_movie_bloc.dart';

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object> get props => [];
}

class NowPlayingMovieInitial extends NowPlayingMovieState {}

class NowPlayingMovieLoading extends NowPlayingMovieState {}

class NowPlayingMovieError extends NowPlayingMovieState {
  final String e;
  const NowPlayingMovieError(this.e);
  @override
  List<Object> get props => [e];
}

class NowPlayingMovieSuccess extends NowPlayingMovieState {
  final ListMovieModel data;
  const NowPlayingMovieSuccess(this.data);

  @override
  List<Object> get props => [data];
}
