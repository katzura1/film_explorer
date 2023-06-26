part of 'detail_movie_bloc.dart';

abstract class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object> get props => [];
}

class DetailMovieInitial extends DetailMovieState {}

class DetailMovieLoading extends DetailMovieState {}

class DetailMovieError extends DetailMovieState {
  final String e;
  const DetailMovieError(this.e);

  @override
  List<Object> get props => [e];
}

class DetailMovieSuccess extends DetailMovieState {
  final DetailMovieModel detail;
  final CreditMovieModel credit;
  final ReviewMovieModel review;
  final ListMovieModel recomendation;
  final List<TrailerMovieModel> trailer;

  const DetailMovieSuccess(this.detail, this.credit, this.review, this.recomendation, this.trailer);

  @override
  List<Object> get props => [detail, credit, review, recomendation, trailer];
}
