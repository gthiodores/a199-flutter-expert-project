import 'package:core/domain/entities/movie.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';

import '../../domain/usecase/search_tv.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTv _searchTv;

  TvSearchNotifier(this._searchTv);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _searchResult = [];
  List<Movie> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await _searchTv.execute(query);
    result.fold(
      (err) {
        _message = err.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
