import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late GetTvRecommendations usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvRecommendations(mockTvRepository);
  });

  final int testId = 1;

  test('should return a list of Movie from the repository', () async {
    // arrange
    when(mockTvRepository.getTvRecommendation(testId))
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.execute(testId);
    // assert
    expect(result, Right(testMovieList));
  });
}
