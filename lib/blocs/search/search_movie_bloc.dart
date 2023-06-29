import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/list_movie_model.dart';
import '../../services/movie_service.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  SearchMovieBloc() : super(SearchMovieInitial()) {
    on<SearchMovieEvent>((event, emit) async {
      if (event is SearchMovieGet) {
        try {
          emit(SearchMovieLoading());
          final data = await MovieService().searchMovies(event.param, event.page);
          emit(SearchMovieSuccess(data));
        } catch (e) {
          emit(SearchMovieError(e.toString()));
        }
      }
      if (event is SearchMovieGetMore) {
        try {
          ListMovieModel data = (state as SearchMovieSuccess).data;
          emit(SearchMovieLoading());
          await MovieService().searchMovies(event.param, event.page).then((value) {
            List<Movie> updatedResult = data.results!;
            updatedResult.addAll(value.results!);
            data = data.copyWith(
              page: value.page,
              results: updatedResult,
              totalPages: value.totalPages,
              totalResults: value.totalResults,
            );
            emit(SearchMovieSuccess(data));
          });
        } catch (e) {
          emit(SearchMovieError(e.toString()));
        }
      }
    });
  }
}
