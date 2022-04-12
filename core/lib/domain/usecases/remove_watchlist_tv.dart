import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/tv_detail.dart';
import '../repositories/tv_repository.dart';

class RemoveWatchlistTv {
  final TvRepository _tvRepository;

  RemoveWatchlistTv(this._tvRepository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return _tvRepository.removeWatchListTv(tv);
  }
}
