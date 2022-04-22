import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
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

      detail.fold(
        (failure) => emit(MovieDetailError(failure.message)),
        (data) async {
          final watchListStatus = await getWatchListStatus.execute(data.id);
          emit(MovieDetailLoaded(data, watchListStatus, [], null));

          final recommendations = await getRecommendations.execute(data.id);
          recommendations.fold(
            (failure) => emit(
              MovieDetailLoaded(data, watchListStatus, [], failure.message),
            ),
            (recommendation) => emit(
              MovieDetailLoaded(data, watchListStatus, recommendation, null),
            ),
          );
        },
      );
    });

    on<MovieDetailWatchListTapped>((event, emit) async {
      if (state is MovieDetailLoaded) {
        final loadedState = state as MovieDetailLoaded;

        Either<Failure, String> result;

        if (loadedState.isFavorite) {
          result = await removeWatchlist.execute(loadedState.movie);
        } else {
          result = await saveWatchlist.execute(loadedState.movie);
        }

        result.fold(
          (failure) => emit(loadedState.copyWith(message: failure.message)),
          (data) => emit(
            loadedState.copyWith(
                message: data, isFavorite: !loadedState.isFavorite),
          ),
        );
      }
    });
  }
}
