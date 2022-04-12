import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class SearchTv {
  final TvRepository _tvRepository;

  SearchTv(this._tvRepository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return _tvRepository.searchTv(query);
  }
}
