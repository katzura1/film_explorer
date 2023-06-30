import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/list_movie_model.dart';
import '../../services/movie_service.dart';

part 'genre_movie_event.dart';
part 'genre_movie_state.dart';

class GenreMovieBloc extends Bloc<GenreMovieEvent, GenreMovieState> {
  GenreMovieBloc() : super(GenreMovieInitial()) {
    on<GenreMovieEvent>((event, emit) async {
      if (event is GenreMovieGet) {
        try {
          emit(GenreMovieLoading());
          final data = await MovieService().getMovieByGenre(event.genreId, event.page);
          emit(GenreMovieSuccess(data));
        } catch (e) {
          emit(GenreMovieError(e.toString()));
        }
      }
      if (event is GenreMovieGetMore) {
        try {
          ListMovieModel data = (state as GenreMovieSuccess).data;
          emit(GenreMovieLoading());
          await MovieService().getMovieByGenre(event.genreId, event.page).then((value) {
            List<Movie> updatedResult = data.results!;
            updatedResult.addAll(value.results!);
            data = data.copyWith(
              page: value.page,
              results: updatedResult,
              totalPages: value.totalPages,
              totalResults: value.totalResults,
            );
            emit(GenreMovieSuccess(data));
          });
        } catch (e) {
          emit(GenreMovieError(e.toString()));
        }
      }
    });
  }
}
