part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class SearchMovieGet extends SearchMovieEvent {
  final String param;
  final int page;
  const SearchMovieGet(this.param, this.page);
}

class SearchMovieGetMore extends SearchMovieEvent {
  final String param;
  final int page;
  const SearchMovieGetMore(this.param, this.page);
}
