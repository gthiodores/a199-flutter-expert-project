import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/domain/usecases/get_tv_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/save_watchlist_tv.dart';
import 'package:core/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  SaveWatchlistTv,
  RemoveWatchlistTv,
  GetWatchListStatus,
])
void main() {
  late MockGetTvDetail getTvDetail;
  late MockGetWatchListStatus getWatchListStatus;
  late MockGetTvRecommendations getTvRecommendations;
  late MockSaveWatchlistTv saveWatchlistTv;
  late MockRemoveWatchlistTv removeWatchlistTv;
  late TvDetailBloc tvDetailBloc;

  setUp(() {
    getTvDetail = MockGetTvDetail();
    getWatchListStatus = MockGetWatchListStatus();
    getTvRecommendations = MockGetTvRecommendations();
    saveWatchlistTv = MockSaveWatchlistTv();
    removeWatchlistTv = MockRemoveWatchlistTv();
    tvDetailBloc = TvDetailBloc(
      getTvDetail: getTvDetail,
      getWatchListStatus: getWatchListStatus,
      getTvRecommendations: getTvRecommendations,
      saveWatchlistTv: saveWatchlistTv,
      removeWatchlistTv: removeWatchlistTv,
    );
  });

  group('initial loading testing', () {
    test('initial state should be initial', () {
      expect(tvDetailBloc.state, TvDetailState.initial());
    });

    blocTest<TvDetailBloc, TvDetailState>(
      'should return [loading, loaded with watchlist, loaded with watchlist & recommendations]',
      build: () {
        when(getTvDetail.execute(1))
            .thenAnswer((_) async => Right(testTvDetail));
        when(getWatchListStatus.execute(1)).thenAnswer((_) async => true);
        when(getTvRecommendations.execute(1))
            .thenAnswer((realInvocation) async => Right(testMovieList));
        return tvDetailBloc;
      },
      act: (bloc) => tvDetailBloc.add(TvDetailInit(1)),
      expect: () => <TvDetailState>[
        TvDetailState.initial(),
        TvDetailState(
          isWatchlist: true,
          message: null,
          recommendations: null,
          detail: testTvDetail,
        ),
        TvDetailState(
          isWatchlist: true,
          message: null,
          recommendations: testMovieList,
          detail: testTvDetail,
        ),
      ],
      verify: (_) {
        verify(getTvDetail.execute(1));
        verify(getWatchListStatus.execute(1));
        verify(getTvRecommendations.execute(1));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should return [loading, loaded with watchlist, loaded with watchlist failed recommendations]',
      build: () {
        when(getTvDetail.execute(1))
            .thenAnswer((_) async => Right(testTvDetail));
        when(getWatchListStatus.execute(1)).thenAnswer((_) async => true);
        when(getTvRecommendations.execute(1)).thenAnswer(
            (realInvocation) async => Left(ServerFailure('failed')));
        return tvDetailBloc;
      },
      act: (bloc) => tvDetailBloc.add(TvDetailInit(1)),
      expect: () => <TvDetailState>[
        TvDetailState.initial(),
        TvDetailState(
          isWatchlist: true,
          message: null,
          recommendations: null,
          detail: testTvDetail,
        ),
        TvDetailState(
          isWatchlist: true,
          message: 'failed',
          recommendations: [],
          detail: testTvDetail,
        ),
      ],
      verify: (_) {
        verify(getTvDetail.execute(1));
        verify(getWatchListStatus.execute(1));
        verify(getTvRecommendations.execute(1));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should return [loading, loaded with false watchlist, loaded with false watchlist & recommendations]',
      build: () {
        when(getTvDetail.execute(1))
            .thenAnswer((_) async => Right(testTvDetail));
        when(getWatchListStatus.execute(1)).thenAnswer((_) async => false);
        when(getTvRecommendations.execute(1))
            .thenAnswer((realInvocation) async => Right(testMovieList));
        return tvDetailBloc;
      },
      act: (bloc) => tvDetailBloc.add(TvDetailInit(1)),
      expect: () => <TvDetailState>[
        TvDetailState.initial(),
        TvDetailState(
          isWatchlist: false,
          message: null,
          recommendations: null,
          detail: testTvDetail,
        ),
        TvDetailState(
          isWatchlist: false,
          message: null,
          recommendations: testMovieList,
          detail: testTvDetail,
        ),
      ],
      verify: (_) {
        verify(getTvDetail.execute(1));
        verify(getWatchListStatus.execute(1));
        verify(getTvRecommendations.execute(1));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should return [error] when failed to fetch detail',
      build: () {
        when(getTvDetail.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('error')));
        when(getWatchListStatus.execute(1)).thenAnswer((_) async => false);
        when(getTvRecommendations.execute(1))
            .thenAnswer((realInvocation) async => Right(testMovieList));
        return tvDetailBloc;
      },
      act: (bloc) => tvDetailBloc.add(TvDetailInit(1)),
      expect: () => <TvDetailState>[
        TvDetailState.initial(),
        TvDetailState(
          isWatchlist: false,
          message: 'error',
          recommendations: null,
          detail: null,
        ),
      ],
      verify: (_) {
        verify(getTvDetail.execute(1));
        verify(getWatchListStatus.execute(1));
        verify(getTvRecommendations.execute(1));
      },
    );
  });

  group('manipulate watchlist', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [success] when removing watchlist success',
      build: () => tvDetailBloc,
      setUp: () => when(removeWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('success')),
      seed: () => TvDetailState(
        detail: testTvDetail,
        recommendations: testMovieList,
        isWatchlist: true,
      ),
      act: (bloc) => bloc.add(TvDetailRemoveWatchlist(testTvDetail)),
      expect: () => <TvDetailState>[
        TvDetailState(
          detail: testTvDetail,
          message: 'success',
          recommendations: testMovieList,
          isWatchlist: false,
        )
      ],
      verify: (bloc) => verify(removeWatchlistTv.execute(testTvDetail)),
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [failure] when removing watchlist success',
      build: () => tvDetailBloc,
      setUp: () => when(removeWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('failure'))),
      seed: () => TvDetailState(
        detail: testTvDetail,
        recommendations: testMovieList,
        isWatchlist: true,
      ),
      act: (bloc) => bloc.add(TvDetailRemoveWatchlist(testTvDetail)),
      expect: () => <TvDetailState>[
        TvDetailState(
          detail: testTvDetail,
          watchlistMessage: 'failure',
          recommendations: testMovieList,
          isWatchlist: true,
        )
      ],
      verify: (bloc) => verify(removeWatchlistTv.execute(testTvDetail)),
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [failure] when saving watchlist failed',
      build: () => tvDetailBloc,
      setUp: () => when(saveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('failure'))),
      seed: () => TvDetailState(
        detail: testTvDetail,
        message: null,
        isWatchlist: false,
        recommendations: testMovieList,
      ),
      act: (bloc) => bloc.add(TvDetailSaveWatchlist(testTvDetail)),
      expect: () => <TvDetailState>[
        TvDetailState(
          detail: testTvDetail,
          message: null,
          isWatchlist: false,
          recommendations: testMovieList,
          watchlistMessage: 'failure',
        ),
      ],
      verify: (_) => verify(saveWatchlistTv.execute(testTvDetail)),
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [success] when saving watchlist success',
      build: () => tvDetailBloc,
      setUp: () => when(saveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('success')),
      seed: () => TvDetailState(
        detail: testTvDetail,
        message: null,
        isWatchlist: false,
        recommendations: testMovieList,
      ),
      act: (bloc) => bloc.add(TvDetailSaveWatchlist(testTvDetail)),
      expect: () => <TvDetailState>[
        TvDetailState(
          detail: testTvDetail,
          message: 'success',
          isWatchlist: true,
          recommendations: testMovieList,
        ),
      ],
      verify: (_) => verify(saveWatchlistTv.execute(testTvDetail)),
    );
  });
}
