import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:film_explorer/services/movie_service.dart';

import '../../models/list_movie_model.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    on<MovieEvent>((event, emit) async {
      if (event is MovieGet) {
        try {
          emit(MovieLoading());
          final data = await MovieService().getMovies();
          emit(MovieSuccess(data));
        } catch (e) {
          emit(MovieError(e.toString()));
        }
      }
    });
  }
}
