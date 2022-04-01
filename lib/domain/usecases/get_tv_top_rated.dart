import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvTopRated {
  final TvRepository _tvRepository;

  GetTvTopRated(this._tvRepository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _tvRepository.getTopRatedTv();
  }
}
