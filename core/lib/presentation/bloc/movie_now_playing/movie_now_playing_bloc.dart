import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_now_playing_event.dart';

part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies usecase;

  MovieNowPlayingBloc(this.usecase) : super(MovieNowPlayingEmpty()) {
    on<MovieNowPlayingInit>((event, emit) async {
      emit(MovieNowPlayingLoading());

      final result = await usecase.execute();

      result.fold(
        (failure) => emit(MovieNowPlayingError(failure.message)),
        (data) => emit(MovieNowPlayingHasData(data)),
      );
    });
  }
}
