import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getDetail;
  final GetMovieRecommendations getRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc(
    this.getDetail,
    this.getRecommendations,
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
  ) : super(MovieDetailLoading()) {
    on<MovieDetailInit>((event, emit) async {
      emit(MovieDetailLoading());

      final detail = await getDetail.execute(event.movieId);

      await detail.fold(
        (failure) async => emit(MovieDetailError(failure.message)),
        (data) async {
          final watchListStatus = await getWatchListStatus.execute(data.id);
          emit(MovieDetailLoaded(data, watchListStatus, null, null, null));

          final recommendations = await getRecommendations.execute(data.id);
          await recommendations.fold(
            (failure) async => emit(
              MovieDetailLoaded(
                  data, watchListStatus, [], failure.message, null),
            ),
            (recommendation) async => emit(
              MovieDetailLoaded(
                  data, watchListStatus, recommendation, null, null),
            ),
          );
        },
      );
    });

    on<MovieDetailWatchListTapped>((event, emit) async {
      if (state is MovieDetailLoaded) {
        final loadedState = state as MovieDetailLoaded;

        if (event.isFavorite) {
          final result = await removeWatchlist.execute(loadedState.movie);

          result.fold(
            (failure) =>
                emit(loadedState.copyWith(watchlistMessage: failure.message)),
            (data) => emit(
              loadedState.copyWith(
                  message: data, isFavorite: !event.isFavorite),
            ),
          );
        } else {
          final result = await saveWatchlist.execute(loadedState.movie);

          result.fold(
            (failure) =>
                emit(loadedState.copyWith(watchlistMessage: failure.message)),
            (data) => emit(
              loadedState.copyWith(
                  message: data, isFavorite: !event.isFavorite),
            ),
          );
        }
      }
    });
  }
}
