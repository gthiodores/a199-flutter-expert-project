import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository repository;
  late SearchTv usecase;

  setUp(() {
    repository = MockTvRepository();
    usecase = SearchTv(repository);
  });

  test('should return a list of Movie from the repository', () async {
    // arrange
    when(repository.searchTv('')).thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.execute('');
    // assert
    expect(result, equals(Right(testMovieList)));
  });
}
