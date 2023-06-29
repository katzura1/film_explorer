import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:film_explorer/services/movie_service.dart';

import '../../models/credit_movie_model.dart';
import '../../models/detail_movie_model.dart';
import '../../models/list_movie_model.dart';
import '../../models/review_movie_model.dart';
import '../../models/trailer_movie_model.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  DetailMovieBloc() : super(DetailMovieInitial()) {
    on<DetailMovieEvent>((event, emit) async {
      if (event is DetailMovieGet) {
        try {
          emit(DetailMovieLoading());
          final detail = await MovieService().getDetail(event.id);
          final credit = await MovieService().getCredit(event.id);
          final review = await MovieService().getReviewMovie(event.id);
          final recomendation = await MovieService().getRecomendationMovies(event.id);
          final trailer = await MovieService().getTrailerMovie(event.id);
          emit(DetailMovieSuccess(detail, credit, review, recomendation, trailer));
        } catch (e) {
          emit(DetailMovieError(e.toString()));
        }
      }
    });
  }
}
