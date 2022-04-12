import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/tv_repository.dart';

class GetTvTopRated {
  final TvRepository _tvRepository;

  GetTvTopRated(this._tvRepository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _tvRepository.getTopRatedTv();
  }
}
