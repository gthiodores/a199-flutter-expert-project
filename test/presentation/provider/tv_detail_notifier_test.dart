import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  SaveWatchlistTv,
  RemoveWatchlistTv,
  GetWatchListStatus,
])
void main() {
  late MockGetTvDetail getTvDetail;
  late MockGetTvRecommendations getTvRecommendations;
  late MockSaveWatchlistTv saveWatchlistTv;
  late MockRemoveWatchlistTv removeWatchlistTv;
  late MockGetWatchListStatus getWatchListStatus;
  late TvDetailNotifier notifier;
  late int listenerCount;

  setUp(() {
    listenerCount = 0;
    getTvDetail = MockGetTvDetail();
    getTvRecommendations = MockGetTvRecommendations();
    saveWatchlistTv = MockSaveWatchlistTv();
    removeWatchlistTv = MockRemoveWatchlistTv();
    getWatchListStatus = MockGetWatchListStatus();
    notifier = TvDetailNotifier(
      getTvDetail,
      getTvRecommendations,
      saveWatchlistTv,
      removeWatchlistTv,
      getWatchListStatus,
    )..addListener(() {
        listenerCount += 1;
      });
  });

  final tId = 1;

  void _arrangeUsecase() {
    when(getTvDetail.execute(tId)).thenAnswer((_) async => Right(testTvDetail));
    when(getTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(testMovieList));
  }

  group('fetch tv detail', () {
    test('should update state to loading when fetching detail', () {
      // arrange
      _arrangeUsecase();
      // act
      notifier.fetchTvDetail(tId);
      // assert
      expect(notifier.tvDetailState, RequestState.Loading);
      expect(listenerCount, 1);
    });

    test('should fetch detail from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await notifier.fetchTvDetail(tId);
      // assert
      verify(getTvDetail.execute(tId));
      verify(getTvRecommendations.execute(tId));
    });

    test('should show detail and loaded state after fetching successful',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await notifier.fetchTvDetail(tId);
      // assert
      expect(notifier.tvDetailState, RequestState.Loaded);
      expect(notifier.detail, equals(testTvDetail));
      expect(listenerCount, 3);
    });

    test('should show error after fetching failed', () async {
      // arrange
      when(getTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failure')));
      when(getTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right(testMovieList));
      // act
      await notifier.fetchTvDetail(tId);
      // assert
      expect(notifier.tvDetailState, RequestState.Error);
      expect(listenerCount, 2);
    });

    test('should get recommendations after fetching successful', () async {
      // arrange
      _arrangeUsecase();
      // act
      await notifier.fetchTvDetail(tId);
      // assert
      expect(listenerCount, 3);
      expect(notifier.tvDetailState, RequestState.Loaded);
      expect(notifier.recommendationsState, RequestState.Loaded);
      expect(notifier.recommendations, equals(testMovieList));
    });

    test('should show error if fetching recommendations failed', () async {
      // arrange
      when(getTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(getTvRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('failure')));
      // act
      await notifier.fetchTvDetail(tId);
      // assert
      expect(listenerCount, 3);
      expect(notifier.tvDetailState, RequestState.Loaded);
      expect(notifier.recommendationsState, RequestState.Error);
      expect(notifier.message, 'failure');
    });
  });

  group('watchlist', () {
    test('should get watchlist status from usecase', () {
      // arrange
      when(getWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      // act
      notifier.loadWatchlistStatus(tId);
      // assert
      verify(getWatchListStatus.execute(tId));
    });

    test('should call add usecase and get status when adding to watchlist',
        () async {
      // arrange
      when(saveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Success'));
      when(getWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await notifier.addToWatchlist(testTvDetail);
      // assert
      verify(saveWatchlistTv.execute(testTvDetail));
      verify(getWatchListStatus.execute(testTvDetail.id));
    });

    test('should update watchlist status when adding success', () async {
      // arrange
      when(saveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Success'));
      when(getWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await notifier.addToWatchlist(testTvDetail);
      // assert
      expect(listenerCount, 1);
      expect(notifier.watchlistMessage, 'Success');
      expect(notifier.isWatchlist, true);
    });

    test('should update watchlist message when failed to add', () async {
      // arrange
      when(saveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('failure')));
      // act
      await notifier.addToWatchlist(testTvDetail);
      // assert
      verifyNever(getWatchListStatus.execute(testTvDetail.id));
      expect(listenerCount, 1);
      expect(notifier.watchlistMessage, 'failure');
      expect(notifier.isWatchlist, false);
    });

    test(
        'should call remove usecase and get status when removing from watchlist',
        () async {
      // arrange
      when(removeWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Success'));
      when(getWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await notifier.removeFromWatchlist(testTvDetail);
      // assert
      verify(removeWatchlistTv.execute(testTvDetail));
      verify(getWatchListStatus.execute(testTvDetail.id));
    });

    test('should update watchlist status when removing success', () async {
      // arrange
      when(removeWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Success'));
      when(getWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await notifier.removeFromWatchlist(testTvDetail);
      // assert
      expect(listenerCount, 1);
      expect(notifier.watchlistMessage, 'Success');
      expect(notifier.isWatchlist, false);
    });

    test('should update watchlist message when removing failed', () async {
      // arrange
      when(removeWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failure')));
      when(getWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await notifier.removeFromWatchlist(testTvDetail);
      // assert
      verifyNever(getWatchListStatus.execute(testTvDetail.id));
      expect(listenerCount, 1);
      expect(notifier.watchlistMessage, 'Failure');
      expect(notifier.isWatchlist, false);
    });
  });
}
