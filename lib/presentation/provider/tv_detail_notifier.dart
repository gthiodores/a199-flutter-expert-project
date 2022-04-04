import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter/material.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail _getTvDetail;
  final GetTvRecommendations _getTvRecommendations;
  final SaveWatchlistTv _saveWatchlistTv;
  final RemoveWatchlistTv _removeWatchlistTv;
  final GetWatchListStatus _getWatchListStatus;

  TvDetailNotifier(
    this._getTvDetail,
    this._getTvRecommendations,
    this._saveWatchlistTv,
    this._removeWatchlistTv,
    this._getWatchListStatus,
  );

  String _message = '';
  String get message => _message;

  late TvDetail _detail;
  TvDetail get detail => _detail;

  RequestState _tvDetailState = RequestState.Empty;
  RequestState get tvDetailState => _tvDetailState;

  List<Movie> _recommendations = [];
  List<Movie> get recommendations => _recommendations;

  RequestState _recommendationsState = RequestState.Empty;
  RequestState get recommendationsState => _recommendationsState;

  bool _isWatchlist = false;
  bool get isWatchlist => _isWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchTvDetail(int id) async {
    _tvDetailState = RequestState.Loading;
    notifyListeners();

    final result = await _getTvDetail.execute(id);
    final recommendationsResult = await _getTvRecommendations.execute(id);
    result.fold(
      (failure) {
        _message = failure.message;
        _tvDetailState = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _tvDetailState = RequestState.Loaded;
        _recommendationsState = RequestState.Loading;
        _detail = data;
        notifyListeners();

        recommendationsResult.fold(
          (failure) {
            _message = failure.message;
            _recommendationsState = RequestState.Error;
            notifyListeners();
          },
          (data) {
            _recommendations = data;
            _recommendationsState = RequestState.Loaded;
            notifyListeners();
          },
        );
      },
    );
  }

  Future<void> addToWatchlist(TvDetail tv) async {
    final result = await _saveWatchlistTv.execute(tv);

    await result.fold(
      (failure) {
        _watchlistMessage = failure.message;
        notifyListeners();
      },
      (data) async {
        _watchlistMessage = data;
        loadWatchlistStatus(tv.id);
      },
    );
  }

  Future<void> removeFromWatchlist(TvDetail tv) async {
    final result = await _removeWatchlistTv.execute(tv);

    await result.fold(
      (failure) {
        _watchlistMessage = failure.message;
        notifyListeners();
      },
      (data) async {
        _watchlistMessage = data;
        await loadWatchlistStatus(tv.id);
      },
    );
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await _getWatchListStatus.execute(id);
    _isWatchlist = result;
    notifyListeners();
  }
}
