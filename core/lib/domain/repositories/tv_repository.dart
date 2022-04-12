import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingTv();

  Future<Either<Failure, List<Movie>>> getTopRatedTv();

  Future<Either<Failure, List<Movie>>> getPopularTv();

  Future<Either<Failure, List<Movie>>> searchTv(String query);

  Future<Either<Failure, TvDetail>> getTvDetail(int id);

  Future<Either<Failure, List<Movie>>> getTvRecommendation(int id);

  Future<Either<Failure, String>> saveWatchListTv(TvDetail tv);

  Future<Either<Failure, String>> removeWatchListTv(TvDetail tv);
}
