import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../provider/movie_detail_notifier_test.mocks.dart';

void main() {
  late MockGetMovieDetail getMovieDetail;
  late MockGetMovieRecommendations getMovieRecommendations;
  late MockGetWatchListStatus getWatchListStatus;
  late MockSaveWatchlist saveWatchlist;
  late MockRemoveWatchlist removeWatchlist;
  late MovieDetailBloc detailBloc;

  setUp(() {
    getMovieDetail = MockGetMovieDetail();
    getMovieRecommendations = MockGetMovieRecommendations();
    getWatchListStatus = MockGetWatchListStatus();
    saveWatchlist = MockSaveWatchlist();
    removeWatchlist = MockRemoveWatchlist();
    detailBloc = MovieDetailBloc(
      getMovieDetail,
      getMovieRecommendations,
      getWatchListStatus,
      saveWatchlist,
      removeWatchlist,
    );
  });

  test('initial state is loading', () {
    expect(detailBloc.state, MovieDetailLoading());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
      'should return [loading, loaded with detail, loaded with detail & watchlist & recmommendations]',
      build: () => detailBloc,
      act: (bloc) {
        when(getMovieDetail.execute(1))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(getMovieRecommendations.execute(1))
            .thenAnswer((_) async => Right(testMovieList));
        when(getWatchListStatus.execute(1)).thenAnswer((_) async => true);
        detailBloc.add(MovieDetailInit(1));
      },
      expect: () => <MovieDetailState>[
            MovieDetailLoading(),
            MovieDetailLoaded(testMovieDetail, true, null, null),
            MovieDetailLoaded(testMovieDetail, true, testMovieList, null),
          ],
      verify: (_) {
        verify(getMovieDetail.execute(1));
        verify(getMovieRecommendations.execute(1));
        verify(getWatchListStatus.execute(1));
      });

  blocTest<MovieDetailBloc, MovieDetailState>(
      'should return [loading, loaded with detail, loaded with detail & not watched & failed recommendations]',
      build: () => detailBloc,
      act: (bloc) {
        when(getMovieDetail.execute(1))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(getMovieRecommendations.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('failed')));
        when(getWatchListStatus.execute(1)).thenAnswer((_) async => true);
        detailBloc.add(MovieDetailInit(1));
      },
      expect: () => <MovieDetailState>[
            MovieDetailLoading(),
            MovieDetailLoaded(testMovieDetail, true, null, null),
            MovieDetailLoaded(testMovieDetail, true, [], 'failed'),
          ],
      verify: (_) {
        verify(getMovieDetail.execute(1));
        verify(getMovieRecommendations.execute(1));
        verify(getWatchListStatus.execute(1));
      });

  blocTest<MovieDetailBloc, MovieDetailState>(
      'should return [loading, failed loading detail]',
      build: () => detailBloc,
      act: (bloc) {
        when(getMovieDetail.execute(1)).thenAnswer(
          (_) async => Left(ServerFailure('failed')),
        );
        detailBloc.add(MovieDetailInit(1));
      },
      expect: () => <MovieDetailState>[
            MovieDetailLoading(),
            MovieDetailError('failed'),
          ],
      verify: (_) {
        verify(getMovieDetail.execute(1));
        verifyNever(getWatchListStatus.execute(1));
      });
}
