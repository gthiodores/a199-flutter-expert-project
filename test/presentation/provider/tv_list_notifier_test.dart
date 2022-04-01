import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies, GetNowPlayingMovies, GetPopularMovies])
void main() {
  late MovieListNotifier notifier;
  late MockGetTopRatedMovies getTopRatedMovies;
  late MockGetNowPlayingMovies getNowPlayingMovies;
  late MockGetPopularMovies getPopularMovies;
  late int listenerCallCount;

  setUp(() {
    getTopRatedMovies = MockGetTopRatedMovies();
    getNowPlayingMovies = MockGetNowPlayingMovies();
    getPopularMovies = MockGetPopularMovies();
    listenerCallCount = 0;
    notifier = MovieListNotifier(
      getNowPlayingMovies: getNowPlayingMovies,
      getPopularMovies: getPopularMovies,
      getTopRatedMovies: getTopRatedMovies,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('now playing tv', () {
    test('initial state should be empty', () {
      expect(notifier.nowPlayingState, equals(RequestState.Empty));
    });

    test('should call usecase to get data', () async {
      // arrange
      when(getNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      // act
      notifier.fetchNowPlayingMovies();
      // assert
      verify(getNowPlayingMovies.execute());
    });

    test('should change state to loading when usecase is called', () {
      // arrange
      when(getNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      // act
      notifier.fetchNowPlayingMovies();
      // assert
      expect(notifier.nowPlayingState, equals(RequestState.Loading));
    });

    test('should change Movies when data is loaded successfully ', () async {
      // arrange
      when(getNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      // act
      await notifier.fetchNowPlayingMovies();
      // assert
      expect(notifier.nowPlayingState, equals(RequestState.Loaded));
      expect(notifier.nowPlayingMovies, equals(testMovieList));
      expect(listenerCallCount, 2);
    });

    test('should return error when data failed to load', () async {
      // arrange
      when(getNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchNowPlayingMovies();
      // assert
      expect(notifier.nowPlayingState, equals(RequestState.Error));
      expect(notifier.nowPlayingMovies, equals([]));
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv', () {
    test('initial state should be empty', () {
      expect(notifier.topRatedMoviesState, equals(RequestState.Empty));
    });

    test('should call usecase to get data', () async {
      // arrange
      when(getTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      // act
      notifier.fetchTopRatedMovies();
      // assert
      verify(getTopRatedMovies.execute());
    });

    test('should change state to loading when usecase is called', () {
      // arrange
      when(getTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      // act
      notifier.fetchTopRatedMovies();
      // assert
      expect(notifier.topRatedMoviesState, equals(RequestState.Loading));
    });

    test('should change Movies when data is loaded successfully ', () async {
      // arrange
      when(getTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      // act
      await notifier.fetchTopRatedMovies();
      // assert
      expect(notifier.topRatedMoviesState, equals(RequestState.Loaded));
      expect(notifier.topRatedMovies, equals(testMovieList));
      expect(listenerCallCount, 2);
    });

    test('should return error when data failed to load', () async {
      // arrange
      when(getTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchTopRatedMovies();
      // assert
      expect(notifier.topRatedMoviesState, equals(RequestState.Error));
      expect(notifier.topRatedMovies, equals([]));
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv', () {
    test('initial state should be empty', () {
      expect(notifier.popularMoviesState, equals(RequestState.Empty));
    });

    test('should call usecase to get data', () async {
      // arrange
      when(getPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      // act
      notifier.fetchPopularMovies();
      // assert
      verify(getPopularMovies.execute());
    });

    test('should change state to loading when usecase is called', () {
      // arrange
      when(getPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      // act
      notifier.fetchPopularMovies();
      // assert
      expect(notifier.popularMoviesState, equals(RequestState.Loading));
    });

    test('should change Movies when data is loaded successfully ', () async {
      // arrange
      when(getPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      // act
      await notifier.fetchPopularMovies();
      // assert
      expect(notifier.popularMoviesState, equals(RequestState.Loaded));
      expect(notifier.popularMovies, equals(testMovieList));
      expect(listenerCallCount, 2);
    });

    test('should return error when data failed to load', () async {
      // arrange
      when(getPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchPopularMovies();
      // assert
      expect(notifier.popularMoviesState, equals(RequestState.Error));
      expect(notifier.popularMovies, equals([]));
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
