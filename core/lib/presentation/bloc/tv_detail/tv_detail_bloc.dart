import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/domain/usecases/get_tv_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_detail.dart';

part 'tv_detail_event.dart';

part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
  }) : super(TvDetailState.initial()) {
    on<TvDetailInit>(_initializeBloc);
    on<TvDetailSaveWatchlist>(_saveWatchlist);
    on<TvDetailRemoveWatchlist>(_removeWatchlist);
  }

  void _initializeBloc(TvDetailInit event, Emitter<TvDetailState> emit) async {
    emit(TvDetailState.initial());

    final detailResult = await getTvDetail.execute(event.id);
    final recommendationResult = await getTvRecommendations.execute(event.id);
    final watchlistResult = await getWatchListStatus.execute(event.id);

    detailResult.fold(
      (failure) => emit(state.copyWith(message: failure.message)),
      (detail) {
        emit(state.copyWith(detail: detail, isWatchlist: watchlistResult));

        recommendationResult.fold(
          (failure) => emit(state.copyWith(
            message: failure.message,
            recommendations: [],
          )),
          (list) => emit(state.copyWith(recommendations: list)),
        );
      },
    );
  }

  void _saveWatchlist(
    TvDetailSaveWatchlist event,
    Emitter<TvDetailState> emit,
  ) async {
    final saveResult = await saveWatchlistTv.execute(event.detail);

    saveResult.fold(
      (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
      (msg) => emit(state.copyWith(message: msg, isWatchlist: true)),
    );
  }

  void _removeWatchlist(
    TvDetailRemoveWatchlist event,
    Emitter<TvDetailState> emit,
  ) async {
    final removeResult = await removeWatchlistTv.execute(event.detail);

    removeResult.fold(
      (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
      (msg) => emit(state.copyWith(message: msg, isWatchlist: false)),
    );
  }
}
