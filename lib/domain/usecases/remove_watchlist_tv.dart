import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class RemoveWatchlistTv {
  final TvRepository _tvRepository;

  RemoveWatchlistTv(this._tvRepository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return _tvRepository.removeWatchListTv(tv);
  }
}
