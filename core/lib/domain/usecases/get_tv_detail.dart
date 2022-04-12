import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/tv_detail.dart';
import '../repositories/tv_repository.dart';

class GetTvDetail {
  final TvRepository _repository;

  GetTvDetail(this._repository);

  Future<Either<Failure, TvDetail>> execute(int id) async {
    return _repository.getTvDetail(id);
  }
}
