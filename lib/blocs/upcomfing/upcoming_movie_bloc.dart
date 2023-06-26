import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/list_movie_model.dart';
import '../../services/movie_service.dart';

part 'upcoming_movie_event.dart';
part 'upcoming_movie_state.dart';

class UpcomingMovieBloc extends Bloc<UpcomingMovieEvent, UpcomingMovieState> {
  UpcomingMovieBloc() : super(UpcomingMovieInitial()) {
    on<UpcomingMovieEvent>((event, emit) async {
      if (event is UpcomingMovieGet) {
        try {
          emit(UpcomingMovieLoading());
          final data = await MovieService().getUpcomingMovies();
          emit(UpcomingMovieSuccess(data));
        } catch (e) {
          emit(UpcomingMovieError(e.toString()));
        }
      }
    });
  }
}
