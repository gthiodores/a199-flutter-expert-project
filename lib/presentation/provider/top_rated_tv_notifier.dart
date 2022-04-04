import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:flutter/material.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTvTopRated _getTvTopRated;

  TopRatedTvNotifier(this._getTvTopRated);

  List<Movie> _movieList = [];
  List<Movie> get movieList => _movieList;

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  Future<void> fetchTopRatedTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await _getTvTopRated.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _state = RequestState.Loaded;
        _movieList = data;
        notifyListeners();
      },
    );
  }
}
