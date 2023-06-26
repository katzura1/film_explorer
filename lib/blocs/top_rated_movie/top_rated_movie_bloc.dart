import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/list_movie_model.dart';
import '../../services/movie_service.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  TopRatedMovieBloc() : super(TopRatedMovieInitial()) {
    on<TopRatedMovieEvent>((event, emit) async {
      if (event is TopRatedMovieGet) {
        try {
          emit(TopRatedMovieLoading());
          final data = await MovieService().getTopRatedMovies();
          emit(TopRatedMovieSuccess(data));
        } catch (e) {
          emit(TopRatedMovieError(e.toString()));
        }
      }
    });
  }
}
