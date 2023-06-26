part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class SearchMovieGet extends SearchMovieEvent {
  final String param;
  const SearchMovieGet(this.param);
}
