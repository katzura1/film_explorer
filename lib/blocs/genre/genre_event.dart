part of 'genre_bloc.dart';

abstract class GenreEvent extends Equatable {
  const GenreEvent();

  @override
  List<Object> get props => [];
}

class GenreGet extends GenreEvent {}
