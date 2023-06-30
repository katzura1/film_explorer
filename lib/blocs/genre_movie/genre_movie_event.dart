part of 'genre_movie_bloc.dart';

abstract class GenreMovieEvent extends Equatable {
  const GenreMovieEvent();

  @override
  List<Object> get props => [];
}

class GenreMovieGet extends GenreMovieEvent {
  final int genreId;
  final int page;
  const GenreMovieGet(this.genreId, this.page);
}

class GenreMovieGetMore extends GenreMovieEvent {
  final int genreId;
  final int page;
  const GenreMovieGetMore(this.genreId, this.page);
}
