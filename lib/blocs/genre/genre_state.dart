part of 'genre_bloc.dart';

abstract class GenreState extends Equatable {
  const GenreState();

  @override
  List<Object> get props => [];
}

class GenreInitial extends GenreState {}

class GenreLoading extends GenreState {}

class GenreSuccess extends GenreState {
  final List<GenreModel> data;

  const GenreSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class GenreFailed extends GenreState {
  final String e;
  const GenreFailed(this.e);

  @override
  List<Object> get props => [e];
}
