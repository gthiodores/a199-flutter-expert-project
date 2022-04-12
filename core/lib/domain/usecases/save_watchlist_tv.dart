import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/tv_detail.dart';
import '../repositories/tv_repository.dart';

class SaveWatchlistTv {
  final TvRepository _tvRepository;

  SaveWatchlistTv(this._tvRepository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return _tvRepository.saveWatchListTv(tv);
  }
}
