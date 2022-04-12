import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository repository;
  late GetTvDetail usecase;

  final int testId = 1;

  setUp(() {
    repository = MockTvRepository();
    usecase = GetTvDetail(repository);
  });

  test('should return TvDetail from the repository', () async {
    // arrange
    when(repository.getTvDetail(testId))
        .thenAnswer((_) async => Right(testTvDetail));
    // act
    final result = await usecase.execute(testId);
    // assert
    expect(result, equals(Right(testTvDetail)));
  });
}
