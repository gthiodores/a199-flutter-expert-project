import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/tv_repository.dart';

class GetTvNowPlaying {
  final TvRepository _tvRepository;

  GetTvNowPlaying(this._tvRepository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _tvRepository.getNowPlayingTv();
  }
}
