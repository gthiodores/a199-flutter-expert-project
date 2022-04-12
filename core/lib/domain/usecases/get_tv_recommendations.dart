import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository _tvRepository;

  GetTvRecommendations(this._tvRepository);

  Future<Either<Failure, List<Movie>>> execute(int id) {
    return _tvRepository.getTvRecommendation(id);
  }
}
