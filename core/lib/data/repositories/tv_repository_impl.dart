import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/repositories/tv_repository.dart';
import '../../utils/exception.dart';
import '../../utils/failure.dart';
import '../datasources/movie_local_data_source.dart';
import '../datasources/tv_remote_data_source.dart';
import '../models/movie_table.dart';

class TvRepositoryImpl extends TvRepository {
  final MovieLocalDataSource _movieLocalDataSource;
  final TvRemoteDataSource _tvRemoteDataSource;

  TvRepositoryImpl(
    this._tvRemoteDataSource,
    this._movieLocalDataSource,
  );

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingTv() async {
    try {
      final result = await _tvRemoteDataSource.getNowPlayingTv();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularTv() async {
    try {
      final result = await _tvRemoteDataSource.getPopularTv();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedTv() async {
    try {
      final result = await _tvRemoteDataSource.getTopRatedTv();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTvRecommendation(int id) async {
    try {
      final result = await _tvRemoteDataSource.getTvRecommendations(id);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchListTv(TvDetail tv) async {
    try {
      final result = await _movieLocalDataSource
          .removeWatchlist(MovieTable.fromTvEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchListTv(TvDetail tv) async {
    try {
      final result = await _movieLocalDataSource
          .insertWatchlist(MovieTable.fromTvEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchTv(String query) async {
    try {
      final result = await _tvRemoteDataSource.searchTv(query);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final result = await _tvRemoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
