import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:flutter/material.dart';

class PopularTvNotifier extends ChangeNotifier {
  final GetTvPopular _getTvPopular;

  PopularTvNotifier(this._getTvPopular);

  List<Movie> _movieList = [];
  List<Movie> get movieList => _movieList;

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  Future<void> fetchTvPopular() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await _getTvPopular.execute();
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
