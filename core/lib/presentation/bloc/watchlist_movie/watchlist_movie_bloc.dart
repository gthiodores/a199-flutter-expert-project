import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_event.dart';

part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies usecase;

  WatchlistMovieBloc(this.usecase) : super(WatchListMovieHasData([])) {
    on<FetchWatchlistMovies>((event, emit) async {
      final watchlist = await usecase.execute();

      watchlist.fold(
        (failure) => emit(WatchListMovieError(failure.message)),
        (data) => emit(WatchListMovieHasData(data)),
      );
    });
  }
}
