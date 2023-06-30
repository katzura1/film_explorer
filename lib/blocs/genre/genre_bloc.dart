import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:film_explorer/services/movie_service.dart';

import '../../models/genre_model.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreInitial()) {
    on<GenreEvent>((event, emit) async {
      if (event is GenreGet) {
        try {
          emit(GenreLoading());
          List<GenreModel> data = await MovieService().getGenres();
          emit(GenreSuccess(data));
        } catch (e) {
          emit(GenreFailed(e.toString()));
        }
      }
    });
  }
}
