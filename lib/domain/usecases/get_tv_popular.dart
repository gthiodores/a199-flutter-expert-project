import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

import '../../common/failure.dart';

class GetTvPopular {
  final TvRepository _tvRepository;

  GetTvPopular(this._tvRepository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _tvRepository.getPopularTv();
  }
}
