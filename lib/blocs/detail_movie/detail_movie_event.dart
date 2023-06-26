part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();

  @override
  List<Object> get props => [];
}

class DetailMovieGet extends DetailMovieEvent {
  final int id;
  const DetailMovieGet(this.id);
}
