import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/season_model.dart';
import 'package:core/data/models/tv_detail_model.dart';
import 'package:core/data/models/tv_model.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl tvRepositoryImpl;
  late MockMovieLocalDataSource mockMovieLocalDataSource;
  late MockTvRemoteDataSource mockTvRemoteDataSource;

  setUp(() {
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    mockMovieLocalDataSource = MockMovieLocalDataSource();
    tvRepositoryImpl = TvRepositoryImpl(
      mockTvRemoteDataSource,
      mockMovieLocalDataSource,
    );
  });

  // Test stubs
  final tTvModel = TvModel(
    posterPath: "/posterPath.jpg",
    popularity: 1,
    id: 1,
    backdropPath: "/backdropPath.jpg",
    voteAverage: 1,
    overview: "overview",
    firstAirDate: "",
    originCountry: ["originCountry"],
    genreIds: [1, 2, 3],
    originalLanguage: "originalLanguage",
    voteCount: 1,
    name: "name",
    originalName: "originalName",
  );
  final tTvModelList = [tTvModel];
  final tMovieModel = tTvModel.toEntity();
  final tMovieModelList = [tMovieModel];

  group('get now playing tv', () {
    test('should return a list of movie when call is successful', () async {
      // arrange
      when(mockTvRemoteDataSource.getNowPlayingTv())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await tvRepositoryImpl.getNowPlayingTv();
      // assert
      verify(mockTvRemoteDataSource.getNowPlayingTv());
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieModelList));
    });

    test('should return ServerFailure when remote call fails', () async {
      // arrange
      when(mockTvRemoteDataSource.getNowPlayingTv())
          .thenThrow(ServerException());
      //act
      final result = await tvRepositoryImpl.getNowPlayingTv();
      // assert
      verify(mockTvRemoteDataSource.getNowPlayingTv());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return ConnectionFailure when not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getNowPlayingTv())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await tvRepositoryImpl.getNowPlayingTv();
      // assert
      verify(mockTvRemoteDataSource.getNowPlayingTv());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get popular tv', () {
    test('should return a list of movie when call is successful', () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTv())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await tvRepositoryImpl.getPopularTv();
      // assert
      verify(mockTvRemoteDataSource.getPopularTv());
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieModelList));
    });

    test('should return ServerFailure when remote call fails', () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTv()).thenThrow(ServerException());
      //act
      final result = await tvRepositoryImpl.getPopularTv();
      // assert
      verify(mockTvRemoteDataSource.getPopularTv());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return ConnectionFailure when not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTv())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await tvRepositoryImpl.getPopularTv();
      // assert
      verify(mockTvRemoteDataSource.getPopularTv());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get top rated tv', () {
    test('should return a list of movie when call is successful', () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await tvRepositoryImpl.getTopRatedTv();
      // assert
      verify(mockTvRemoteDataSource.getTopRatedTv());
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieModelList));
    });

    test('should return ServerFailure when remote call fails', () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());
      //act
      final result = await tvRepositoryImpl.getTopRatedTv();
      // assert
      verify(mockTvRemoteDataSource.getTopRatedTv());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return ConnectionFailure when not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await tvRepositoryImpl.getTopRatedTv();
      // assert
      verify(mockTvRemoteDataSource.getTopRatedTv());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get tv recommendations', () {
    final movieId = 1;

    test('should return a list of movie when call is successful', () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(movieId))
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await tvRepositoryImpl.getTvRecommendation(movieId);
      // assert
      verify(mockTvRemoteDataSource.getTvRecommendations(movieId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieModelList));
    });

    test('should return ServerFailure when remote call fails', () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(movieId))
          .thenThrow(ServerException());
      //act
      final result = await tvRepositoryImpl.getTvRecommendation(movieId);
      // assert
      verify(mockTvRemoteDataSource.getTvRecommendations(movieId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return ConnectionFailure when not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(movieId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await tvRepositoryImpl.getTvRecommendation(movieId);
      // assert
      verify(mockTvRemoteDataSource.getTvRecommendations(movieId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get tv detail', () {
    final tTvDetailResponse = TvDetailResponse(
      backdropPath: "backdropPath",
      firstAirDate: "firstAirDate",
      lastAirDate: "lastAirDate",
      genres: [GenreModel(id: 1, name: "genre")],
      id: 1,
      seasons: [
        SeasonModel(
          airDate: "airDate",
          id: 1,
          episodeCount: 1,
          name: "name",
          overview: "overview",
          posterPath: "posterPath",
          seasonNumber: 1,
        )
      ],
      name: "name",
      originalName: "originalName",
      overview: "overview",
      posterPath: "posterPath",
      voteAverage: 1.0,
      voteCount: 1,
    );

    final tTvDetail = TvDetail(
      backdropPath: "backdropPath",
      firstAirDate: "firstAirDate",
      lastAirDate: "lastAirDate",
      genres: [
        Genre(
          id: 1,
          name: "genre",
        )
      ],
      id: 1,
      seasons: [
        Season(
          name: "name",
          overview: "overview",
          posterPath: "posterPath",
          episodeCount: 1,
          airDate: "airDate",
        )
      ],
      name: "name",
      originalName: "originalName",
      overview: "overview",
      posterPath: "posterPath",
      voteAverage: 1.0,
      voteCount: 1,
    );

    test('should return TvDetail when call is successful', () async {
      // arrange
      when(mockTvRemoteDataSource.getTvDetail(1))
          .thenAnswer((_) async => tTvDetailResponse);
      // act
      final result = await tvRepositoryImpl.getTvDetail(1);
      // assert
      verify(mockTvRemoteDataSource.getTvDetail(1));
      expect(result, equals(Right(tTvDetail)));
    });

    test('should return ServerFailure when remote call fails', () async {
      // arrange
      when(mockTvRemoteDataSource.getTvDetail(1)).thenThrow(ServerException());
      // act
      final result = await tvRepositoryImpl.getTvDetail(1);
      // assert
      verify(mockTvRemoteDataSource.getTvDetail(1));
      expect(result, Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvDetail(1))
          .thenThrow(SocketException(''));
      // act
      final result = await tvRepositoryImpl.getTvDetail(1);
      // assert
      verify(mockTvRemoteDataSource.getTvDetail(1));
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('search tv', () {
    test('should return a list of Movie when call is successful', () async {
      // arrange
      when(mockTvRemoteDataSource.searchTv(""))
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await tvRepositoryImpl.searchTv("");
      // assert
      verify(mockTvRemoteDataSource.searchTv(""));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieModelList));
    });

    test('should return ServerFailure when remote call fails', () async {
      // arrange
      when(mockTvRemoteDataSource.searchTv("")).thenThrow(ServerException());
      // act
      final result = await tvRepositoryImpl.searchTv("");
      // assert
      verify(mockTvRemoteDataSource.searchTv(""));
      expect(result, Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.searchTv("")).thenThrow(SocketException(''));
      // act
      final result = await tvRepositoryImpl.searchTv("");
      // assert
      verify(mockTvRemoteDataSource.searchTv(""));
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving tv successful', () async {
      // arrange
      when(mockMovieLocalDataSource.insertWatchlist(testMovieTableTv))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await tvRepositoryImpl.saveWatchListTv(testTvDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving tv unsuccessful', () async {
      // arrange
      when(mockMovieLocalDataSource.insertWatchlist(testMovieTableTv))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await tvRepositoryImpl.saveWatchListTv(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when saving tv successful', () async {
      // arrange
      when(mockMovieLocalDataSource.removeWatchlist(testMovieTableTv))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await tvRepositoryImpl.removeWatchListTv(testTvDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when saving tv unsuccessful', () async {
      // arrange
      when(mockMovieLocalDataSource.removeWatchlist(testMovieTableTv))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await tvRepositoryImpl.removeWatchListTv(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });
}
