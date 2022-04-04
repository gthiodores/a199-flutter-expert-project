import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:ditonton/presentation/provider/popular_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_notifier_test.mocks.dart';

@GenerateMocks([GetTvPopular])
void main() {
  late MockGetTvPopular usecase;
  late PopularTvNotifier notifier;
  late int listenerCount;

  setUp(() {
    listenerCount = 0;
    usecase = MockGetTvPopular();
    notifier = PopularTvNotifier(usecase)
      ..addListener(() {
        listenerCount += 1;
      });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
    // act
    notifier.fetchTvPopular();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
    // act
    await notifier.fetchTvPopular();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.movieList, testMovieList);
    expect(listenerCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(usecase.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTvPopular();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCount, 2);
  });
}
