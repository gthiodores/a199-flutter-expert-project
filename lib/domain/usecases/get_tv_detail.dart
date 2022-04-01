import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvDetail {
  final TvRepository _repository;

  GetTvDetail(this._repository);

  Future<Either<Failure, TvDetail>> execute(int id) async {
    return _repository.getTvDetail(id);
  }
}
