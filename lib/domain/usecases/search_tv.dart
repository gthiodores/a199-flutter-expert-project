import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

import '../../common/failure.dart';

class SearchTv {
  final TvRepository _tvRepository;

  SearchTv(this._tvRepository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return _tvRepository.searchTv(query);
  }
}
