import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/get_tv_now_playing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late GetTvNowPlaying usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvNowPlaying(mockTvRepository);
  });

  test('should get list of Movie from the repository', () async {
    // arrange
    when(mockTvRepository.getNowPlayingTv())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, equals(Right(testMovieList)));
  });
}
