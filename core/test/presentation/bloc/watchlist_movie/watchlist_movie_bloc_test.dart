import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies watchlistMovies;
  late WatchlistMovieBloc watchlistMovieBloc;

  setUp(() {
    watchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(watchlistMovies);
  });

  test('initial state must be has data with empty content', () {
    expect(watchlistMovieBloc.state, WatchListMovieHasData([]));
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should load data when fetch is triggered',
    build: () => watchlistMovieBloc,
    act: (bloc) {
      when(watchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      watchlistMovieBloc
          .add(FetchWatchlistMovies(DateTime.now().millisecondsSinceEpoch));
    },
    expect: () => <WatchlistMovieState>[WatchListMovieHasData(testMovieList)],
    verify: (_) => verify(watchlistMovies.execute()),
  );
}
