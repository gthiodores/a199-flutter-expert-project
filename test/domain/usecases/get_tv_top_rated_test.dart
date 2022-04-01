import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository repository;
  late GetTvTopRated usecase;

  setUp(() {
    repository = MockTvRepository();
    usecase = GetTvTopRated(repository);
  });

  test('should return a list of Movie from the repository', () async {
    // arrange
    when(repository.getTopRatedTv())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, equals(Right(testMovieList)));
  });
}
