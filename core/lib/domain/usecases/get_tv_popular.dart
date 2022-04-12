import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/tv_repository.dart';

class GetTvPopular {
  final TvRepository _tvRepository;

  GetTvPopular(this._tvRepository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _tvRepository.getPopularTv();
  }
}
