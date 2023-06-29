import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:film_explorer/services/movie_service.dart';

import '../../models/list_movie_model.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  NowPlayingMovieBloc() : super(NowPlayingMovieInitial()) {
    on<NowPlayingMovieEvent>((event, emit) async {
      if (event is NowPlayingMovieGet) {
        try {
          emit(NowPlayingMovieLoading());
          final data = await MovieService().getNowPlayingMovies();
          emit(NowPlayingMovieSuccess(data));
        } catch (e) {
          emit(NowPlayingMovieError(e.toString()));
        }
      }
    });
  }
}
