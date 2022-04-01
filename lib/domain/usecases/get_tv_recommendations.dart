import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository _tvRepository;

  GetTvRecommendations(this._tvRepository);

  Future<Either<Failure, List<Movie>>> execute(int id) {
    return _tvRepository.getTvRecommendation(id);
  }
}
