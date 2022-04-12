import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_tv_now_playing.dart';
import '../../domain/usecases/get_tv_popular.dart';
import '../../domain/usecases/get_tv_top_rated.dart';
import '../../utils/failure.dart';
import '../../utils/state_enum.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowPlayingMovies = <Movie>[];
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularMovies = <Movie>[];
  List<Movie> get popularMovies => _popularMovies;

  RequestState _popularMoviesState = RequestState.Empty;
  RequestState get popularMoviesState => _popularMoviesState;

  var _topRatedMovies = <Movie>[];
  List<Movie> get topRatedMovies => _topRatedMovies;

  RequestState _topRatedMoviesState = RequestState.Empty;
  RequestState get topRatedMoviesState => _topRatedMoviesState;

  String _message = '';
  String get message => _message;

  final GetTvNowPlaying _getTvNowPlaying;
  final GetTvTopRated _getTvTopRated;
  final GetTvPopular _getTvPopular;

  TvListNotifier(
    this._getTvNowPlaying,
    this._getTvTopRated,
    this._getTvPopular,
  );

  Future<void> fetchNowPlayingTv() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await _getTvNowPlaying.execute();
    result.fold(
      (Failure failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (List<Movie> moviesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTv() async {
    print("fetch top rated called");
    _topRatedMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await _getTvTopRated.execute();
    result.fold(
      (Failure failure) {
        print("fetch top rated failed");
        _topRatedMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (List<Movie> moviesData) {
        print("fetch top rated success");
        _topRatedMoviesState = RequestState.Loaded;
        _topRatedMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTv() async {
    print("fetch popular called");
    _popularMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await _getTvPopular.execute();
    result.fold(
      (Failure failure) {
        print("fetch popular failed");
        _popularMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (List<Movie> moviesData) {
        print("fetch popular success");
        _popularMoviesState = RequestState.Loaded;
        _popularMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
